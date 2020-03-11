{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "dftech-tools";
  version = "1.3.5";
  src = fetchurl {
    url = "https://github.com/dafiti-group/${name}/releases/download/${version}/${name}_${version}_linux_amd64.tar.gz";
    sha256 = "5a095a0768af855cca64262609353c58879ad012409e51595399cbf2866644fd";
  };
  setSourceRoot = "sourceRoot=`pwd`";
  installPhase = ''
    install -Dm755 "dftech" -t "$out/bin"
  '';
  meta = with stdenv.lib; {
    homepage = https://github.com/dafiti-group/dftech-tools;
    description = "Dafiti tools";
    platforms = platforms.linux;
    license = licenses.mit;
    maintainers = with stdenv.lib.maintainers; [ catern ];
  };
}