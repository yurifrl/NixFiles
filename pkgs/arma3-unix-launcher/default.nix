{ stdenv, fetchurl, fmt, pugixml, pkgs }:

stdenv.mkDerivation rec {
  name = "arma3-unix-launcher";
  gittag = "commit-217";
  pkgname = "arma3-unix-launcher-bin";
  pkgver = "217.de66aa2";
  pkgrel = "1";
  url = "https://github.com/muttleyxd/arma3-unix-launcher/releases/download/${gittag}/arma3-unix-launcher-${pkgver}-${pkgrel}-archlinux-x86_64.pkg.tar.xz";
  src = fetchurl {
    url = url;
    sha256 = "93b1dba0a07adc42f03276cd04a9b8c566f86e3a9b7b637af2bac5e0a5c73979";
  };

  installPhase = ''
    mkdir -p $out/{bin,share}
    mv share $out/
    install -Dm755 bin/$name "$out/bin/$name"
  '';

  nativeBuildInputs = [];
  buildInputs = with pkgs; [
    fmt
    pugixml
    qt5.qtbase
    qt5.qtsvg
  ];
  meta = with stdenv.lib; {
      description = "";
      homepage = "";
      maintainers = with maintainers; [ yurifrl ];
      license = licenses.gpl2;
      platforms = platforms.linux;
  };
}
