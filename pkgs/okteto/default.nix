{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "okteto";
  version = "1.8.18";
  src = fetchurl {
    name = name;
    url = "https://github.com/${name}/${name}/releases/download/${version}/${name}-Linux-x86_64";
    sha256 = "1aynghnqdi8j5ml00778wz1kky9p89p78g6wryvldnmljz9b00a5";
    executable = true;
  };

  phases = ["installPhase"];
  installPhase = ''install -Dm755 $src "$out/bin/$name"'';

  meta = with stdenv.lib; {
      description = "";
      homepage = "";
      maintainers = with maintainers; [ yurifrl ];
      license = licenses.gpl2;
      platforms = platforms.linux;
  };
}
