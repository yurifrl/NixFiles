{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "krew";
  version = "0.3.4";
  src = fetchurl {
    url = "https://github.com/kubernetes-sigs/krew/releases/download/v${version}/krew.tar.gz";
    sha256 = "6629b1d7ad215322361f8dd270396fd1a23555fdbde8dcc1ba4ad860978b319a";
  };
  setSourceRoot = "sourceRoot=`pwd`";
  installPhase = ''
    mv krew-linux_amd64 krew
    install -Dm755 "krew" -t "$out/bin"
  '';
  meta = with stdenv.lib; {
    homepage = https://github.com/kubernetes-sigs/krew;
    description = "Krew";
    platforms = platforms.linux;
    license = licenses.mit;
    maintainers = with stdenv.lib.maintainers; [ catern ];
  };
}