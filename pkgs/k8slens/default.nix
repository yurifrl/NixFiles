{ lib, fetchurl, appimageTools, pkgs }:

# https://github.com/NixOS/nixpkgs/blob/cda0a60c08fe6dd0dd46605bc6616839b0670a5b/pkgs/applications/audio/plexamp/default.nix
# https://github.com/lensapp/lens/releases/download/v3.5.3/Lens-3.5.3.AppImage
let
  pname = "lens";
  version = "3.5.3";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://github.com/lensapp/lens/releases/download/v${version}/Lens-${version}.AppImage";
    sha256 = "0nm8n66hzz2r5q6qi27crvr90lri56h52qvij5xgirhb2y77h6lv";
    name="${name}.AppImage";
  };

  appimageContents = appimageTools.extractType2 {
    inherit name src;
  };
in appimageTools.wrapType2 {
  inherit name src;

  multiPkgs = null; # no 32bit needed
  extraPkgs = pkgs: appimageTools.defaultFhsEnvArgs.multiPkgs pkgs ++ [ pkgs.bash ];

  extraInstallCommands = ''
    ln -s $out/bin/${name} $out/bin/${pname}
    install -m 444 -D ${appimageContents}/kontena-lens.desktop $out/share/applications/kontena-lens.desktop
    install -m 444 -D ${appimageContents}/kontena-lens.png \
      $out/share/icons/hicolor/512x512/apps/kontena-lens.png
    substituteInPlace $out/share/applications/kontena-lens.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'
  '';

  meta = with lib; {
      description = "";
      homepage = "";
      maintainers = with maintainers; [ yurifrl ];
      license = licenses.gpl2;
      platforms = platforms.linux;
  };
}