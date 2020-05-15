{ lib, buildGoModule, fetchFromGitHub, tree }:

buildGoModule rec {
  pname = "kubebuilder";
  version = "2.3.1";
  rev = "8b53abeb4280186e494b726edf8f54ca7aa64a49";

  src = fetchFromGitHub {
    owner = "kubernetes-sigs";
    repo = pname;
    rev = "v${version}";
    sha256 = "07frc9kl6rlrz2hjm72z9i12inn22jqykzzhlhf9mcr9fv21s3gk";
  };

  # avoid finding test and development commands
  sourceRoot = "source/cmd";

  modSha256 = "0fbvj098c7aabilycdl4rcm7aylkc4q44z4wjlpkcpnqkfkq4xzi";

  meta = with lib; {
    description = "Customization of kubernetes YAML configurations";
    longDescription = ''
    '';
    homepage = "https://github.com/kubernetes-sigs/kubebuilder";
    license = licenses.asl20;
    maintainers = with maintainers; [];
  };
}
