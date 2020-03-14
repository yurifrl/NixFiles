{ stdenv, fetchurl, dpkg }:

with stdenv.lib;

let
in stdenv.mkDerivation {
  name = "nordvpn";
  meta = {
    homepage = https://nordvpn.com/download/linux/;
    description = "";
    platforms = platforms.linux;
  };
  buildInputs = [ dpkg ];
  src = fetchurl {
    url = "https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb";
    sha256 = "16a05919b7259e679e4483aa39f61ef9bc9c07cbe040276e04884b5f9d7f933d";
  };

  unpackCmd = "${dpkg}/bin/dpkg-deb -x $curSrc .";

  #unpackPhase = "true";
  #setSourceRoot = "sourceRoot=`pwd`";
  installPhase = ''
    echo "=================="
    mkdir -p $out
    ls
    #cp -r . $out/
    #ls $out/
    echo "=================="
  '';
}
