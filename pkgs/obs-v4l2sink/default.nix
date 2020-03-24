{ stdenv, fetchFromGitHub, cmake, pkgs, libv4l, x264 }:

with stdenv.lib;

let
  name = "obs-v4l2sink";
in stdenv.mkDerivation {
  inherit name;

  version = "latest";
  src = fetchFromGitHub {
    owner = "CatxFish";
    repo = "obs-v4l2sink";
    rev = "master";
    sha256 = "03ah91cm1qz26k90mfx51l0d598i9bcmw39lkikjs1msm4c9dfxx";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = with pkgs; [
    x264
    libv4l
    qt5.qtbase
    qt5.qtx11extras
    qt5.qtsvg
  ];

  cmakeFlags = [ "-DCMAKE_CXX_FLAGS=-DDL_OPENGL=\\\"$(out)/lib/libobs-opengl.so\\\"" ];

  installPhase = ''
    echo "==============="
    ls
    mkdir build && cd build
    cmake -DLIBOBS_INCLUDE_DIR="../../obs-studio/libobs" -DCMAKE_INSTALL_PREFIX=/usr ..
    make -j4
    make install
    echo "==============="
  '';

  meta = {
    homepage = "https://github.com/CatxFish/obs-v4l2sink";
    description = "An OBS Studio plugin that provides output capabilities to a Video4Linux2 device";
    license = licenses.mit;
    maintainers = [ maintainers.vyp ];
    platforms = platforms.linux;
  };
}
