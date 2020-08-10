{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  version = "0.17.0";
  pname = "tilt";
  owner = "tilt-dev";
  src = fetchurl {
    url = "https://github.com/${owner}/${pname}/releases/download/v${version}/${pname}.${version}.linux.x86_64.tar.gz";
    sha256 = "0drazi8qv0j6m8x89yk6hnlswjrhvlqaw5fd20j4ggq1577m9h0s";
  };

  sourceRoot = ".";

  installPhase = ''
    install -Dm755 "tilt" -t "$out/bin"
  '';

  meta = with stdenv.lib; {
      description = "";
      homepage = "";
      maintainers = with maintainers; [ yurifrl ];
      license = licenses.gpl2;
      platforms = platforms.linux;
  };
}
