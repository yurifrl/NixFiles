{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  version = "0.16.1";
  pname = "tilt";
  owner = "tilt-dev";
  src = fetchurl {
    url = "https://github.com/${owner}/${pname}/releases/download/v${version}/${pname}.${version}.linux.x86_64.tar.gz";
    sha256 = "158cz1bnffysiq510hh94v2053dlq7qgppnklm8h188x7him5ax4";
  };

  sourceRoot = ".";

  installPhase = ''
    install -Dm755 "tilt" -t "$out/bin"
  '';

  meta = with stdenv.lib; {
      description = "";
      homepage = "";
      maintainers = with maintainers; [ yurifrl ];
      license = licenses.gpl2;
      platforms = platforms.linux;
  };
}
