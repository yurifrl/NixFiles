{ lib, buildGoModule, fetchFromGitHub, tree, makeWrapper }:

buildGoModule rec {
  pname = "kubebuilder";
  version = "2.3.1";
  # rev = "f07a0146a40b1dc4048b1caaf075efcf1312aa00";

  buildFlagsArray = let t = "sigs.k8s.io/kubebuilder"; in ''
    -ldflags=
      -s -X ${t}.version=${version}
         -X ${t}.buildDate=unknown
  '';

  src = fetchFromGitHub {
    owner = "kubernetes-sigs";
    repo = pname;
    rev = "v${version}";
    sha256 = "07frc9kl6rlrz2hjm72z9i12inn22jqykzzhlhf9mcr9fv21s3gk";
  };

  # avoid finding test and development commands
  buildPhase = ''
    echo "========"
    pwd
    ls
    go install ./cmd
    exit 1
  '';

  modSha256 = "0fbvj098c7aabilycdl4rcm7aylkc4q44z4wjlpkcpnqkfkq4xzi";

  meta = with lib; {
    description = "Customization of kubernetes YAML configurations";
    longDescription = ''
    '';
    homepage = "https://github.com/kubernetes-sigs/kubebuilder";
    license = licenses.asl20;
    maintainers = with maintainers; [ yurifrl ];
  };
}
