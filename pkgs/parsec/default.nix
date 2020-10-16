{ lib, stdenv, fetchurl, alsaLib, dbus, libGL, libpulseaudio, libva,
makeDesktopItem, libudev, xorg }:

# https://github.com/delroth/infra.delroth.net/blob/master/pkgs/parsec.nix
let
  pname = "parsec";
  binaryName = "parsecd";
  desktopName = "Parsec";
  version = "2020-01-29";

in stdenv.mkDerivation rec {
  inherit pname binaryName desktopName version;

  src = fetchurl {
    url = "https://builds.parsecgaming.com/package/parsec-linux.deb";
    sha256 = "1hfdzjd8qiksv336m4s4ban004vhv00cv2j461gc6zrp37s0fwhc";
  };

  runtimeDependencies = [
    alsaLib dbus.lib libGL libpulseaudio libva.out stdenv.cc.cc.lib libudev
    xorg.libX11 xorg.libXcursor xorg.libXi xorg.libXinerama xorg.libXrandr
    xorg.libXScrnSaver
  ];

  desktopItem = makeDesktopItem {
    name = pname;
    exec = binaryName;
    icon = pname;
    inherit desktopName;
    genericName = meta.description;
    categories = "Network;InstantMessaging;";
    mimeType = "x-scheme-handler/parsec";
  };

  unpackPhase = ''
    ar p "$src" data.tar.xz | tar xJ
  '';

  installPhase = ''
    mkdir -p $out/bin $out/libexec $out/share
    cp usr/bin/parsecd $out/libexec
    cp -r usr/share/parsec/skel $out/libexec
    # parsecd is a small wrapper binary which copies skel/* to ~/.parsec and
    # then runs from there. Unfortunately, it hardcodes the /usr/share/parsec
    # path, and patching that would be annoying. Instead, just reproduce the
    # install logic in a wrapper script.
    cat >$out/bin/parsecd <<EOF
    #! /bin/sh
    mkdir -p \$HOME/.parsec
    ln -sf $out/libexec/skel/* \$HOME/.parsec
    exec $out/libexec/parsecd
    EOF
    chmod +x $out/bin/parsecd

    ln -s "${desktopItem}/share/applications" $out/share/
  '';

  postFixup = ''
    # We do not use autoPatchelfHook since we need runtimeDependencies rpath to
    # also be set on the .so, not just on the main executable.
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
        $out/libexec/parsecd
    rpath=""
    for dep in $runtimeDependencies; do
      rpath="$rpath''${rpath:+:}$dep/lib"
    done
    patchelf --set-rpath "$rpath" $out/libexec/parsecd
    patchelf --set-rpath "$rpath" $out/libexec/skel/*.so
  '';

  meta = with lib; {
    description = "Remotely connect to a gaming PC for a low latency remote computing experience";
    homepage = "https://parsecgaming.com/";
    license = licenses.unfree;
    maintainers = with maintainers; [ delroth ];
  };
}
