{ stdenv, fetchurl }:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "krew";
  version = "0.3.4";
  meta = with stdenv.lib; {
    homepage = https://github.com/kubernetes-sigs/krew;
    description = "Krew";
    platforms = platforms.linux;
    license = licenses.mit;
    maintainers = with stdenv.lib.maintainers; [ yuri ];
  };
  src = fetchurl {
    url = "https://github.com/kubernetes-sigs/krew/releases/download/v${version}/krew.tar.gz";
    sha256 = "6629b1d7ad215322361f8dd270396fd1a23555fdbde8dcc1ba4ad860978b319a";
  };
  setSourceRoot = "sourceRoot=`pwd`";
  installPhase = ''
    KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64"
    mv $KREW krew
    install -Dm755 "krew" -t "$out/bin"
  '';
}