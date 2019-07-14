{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "kconf";
  version = "1.0.4";
  src = fetchurl {
    url = "https://github.com/yurifrl/${name}/releases/download/${version}/${name}_${version}_linux_amd64.tar.gz";
    sha256 = "aa718a9fdf4cdcb4f0779b225743c13bd09b88884df44bd82f0cd2c995b713cc";
  };
  setSourceRoot = "sourceRoot=`pwd`";
  installPhase = ''
    install -Dm755 "kconf" -t "$out/bin"
  '';
  meta = with stdenv.lib; {
    homepage = https://github.com/yurifrl/kconf;
    description = "Kubernetes configuration manager";
    platforms = platforms.linux;
    license = licenses.mit;
    maintainers = with stdenv.lib.maintainers; [ catern ];
  };
}