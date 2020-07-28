{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "kubeseal";
  version = "0.12.4";
  src = fetchurl {
    name = name;
    url = "https://github.com/bitnami-labs/sealed-secrets/releases/download/v${version}/${name}-linux-amd64";
    sha256 = "0s4zxy4qcibbzpazm81ixj3s3aznzla5xh3zidk201h4ci6vzjrz";
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
