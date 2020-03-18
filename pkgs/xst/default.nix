{ stdenv, fetchFromGitHub, pkgconfig, libX11, ncurses, libXext, libXft, fontconfig }:

with stdenv.lib;

let
  version = "0.7.2";
  name = "xst-${version}";
in stdenv.mkDerivation {
  inherit name;

  src = fetchFromGitHub {
    owner = "yurifrl";
    repo = "xst";
    rev = "master";
    sha256 = "10yhfhx40p45cbw5igr9mhaniq5wsdv60l5a14hqdnlzr9jglmh5";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ libX11 ncurses libXext libXft fontconfig ];

  installPhase = ''
    TERMINFO=$out/share/terminfo make install PREFIX=$out
  '';

  meta = {
    homepage = https://github.com/neeasade/xst;
    description = "Simple terminal fork that can load config from Xresources";
    license = licenses.mit;
    maintainers = [ maintainers.vyp ];
    platforms = platforms.linux;
  };
}
