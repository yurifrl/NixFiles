{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "argocd";
  org = "argoproj";
  project = "argo-cd";
  version = "1.7.3";
  src = fetchurl {
    name = name;
    url = "https://github.com/${org}/${project}/releases/download/v${version}/${name}-linux-amd64";
    sha256 = "10k46ycdnf8qri1x968n9j5gfawwvdrcghq8a02m720ja4jq2lwa";
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
