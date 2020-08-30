{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  version = "1.18.9-rc.0";
  name = "kubectl";
  src = fetchurl {
    url = "https://storage.googleapis.com/kubernetes-release/release/v${version}/bin/linux/amd64/kubectl";
    sha256 = "148iy2zsfp5n9finzjjzdrpyipsw09spyxi8z8fm4qza8qs5lwj9";
    name = name;
    executable = true;
  };

  sourceRoot = ".";

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
