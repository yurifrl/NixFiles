{ stdenv, fetchFromGitHub, pkgconfig, libX11, ncurses, libXext, libXft, fontconfig }:

with stdenv.lib;

let
  name = "st";
in stdenv.mkDerivation {
  inherit name;

  src = fetchGit {
    url = "https://github.com/gnotclub/xst";
    ref = "master";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ libX11 ncurses libXext libXft fontconfig ];

  installPhase = ''
    TERMINFO=$out/share/terminfo make install PREFIX=$out
    mv $out/bin/xst $out/bin/st
  '';

  meta = {
    homepage = https://github.com/gnotclub/xst;
    description = "Simple terminal fork that can load config from Xresources";
    license = licenses.mit;
    maintainers = [ maintainers.vyp ];
    platforms = platforms.linux;
  };
}
