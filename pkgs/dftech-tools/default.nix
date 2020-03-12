{ stdenv, fetchFromGitHub, fetchgitPrivate, fetchurl }:

stdenv.mkDerivation rec {
  name = "dftech-tools";
  version = "1.3.5";
  meta = with stdenv.lib; {
    homepage = https://github.com/dafiti-group/dftech-tools;
    description = "Dafiti tools";
    platforms = platforms.linux;
    license = licenses.mit;
    maintainers = with stdenv.lib.maintainers; [ catern ];
  };
  setSourceRoot = "sourceRoot=`pwd`";
  
  # src = fetchurl {
  #   url = "https://github.com/yurifrl/kconf/releases/download/1.0.4/kconf_1.0.4_linux_amd64.tar.gz";
  #   sha256 = "aa718a9fdf4cdcb4f0779b225743c13bd09b88884df44bd82f0cd2c995b713cc";
  # };
  # src = fetchFromGitHub {
  #   owner = "dafiti-group";
  #   repo = "dftech-tools";
  #   rev = "v${version}";
  #   sha256 = "5a095a0768af855cca64262609353c58879ad012409e51595399cbf2866644fd";
  #   private = true;
  # };

  src = fetchgitPrivate {
    url = "git@github.com:dafiti-group/dftech-tools.github.io.git";
    rev = "afd26252c33d9896abd36e396a6eec73b951fad3";
    sha256 = "5a095a0768af855cca64262609353c58879ad012409e51595399cbf2866644fd";
  };

  installPhase = ''
    echo $NIX_GITHUB_PRIVATE_USERNAME
    echo $NIX_GITHUB_PRIVATE_PASSWORD
  '';
}