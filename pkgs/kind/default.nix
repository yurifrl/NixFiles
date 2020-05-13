{ stdenv, buildGoPackage, fetchFromGitHub, installShellFiles }:

with stdenv.lib;

buildGoPackage rec {
  pname = "kind";
  version = "0.8.1";

  src = fetchFromGitHub {
    rev    = "v${version}";
    owner  = "kubernetes-sigs";
    repo   = "kind";
    sha256 = "0r301nqvycik8fwlghq0cymmq4rm7xp8haj39i2nynxyw8zk6zym";
  };

  goDeps = ./deps.nix;
  goPackagePath = "sigs.k8s.io/kind";
  subPackages = [ "." ];

  nativeBuildInputs = [ installShellFiles ];
  # postInstall = ''
  #   for shell in bash zsh; do
  #     $out/bin/kind completion $shell > kind.$shell
  #     installShellCompletion kind.$shell
  #   done
  # '';

  meta = {
    description = "Kubernetes IN Docker - local clusters for testing Kubernetes";
    homepage    = "https://github.com/kubernetes-sigs/kind";
    maintainers = with maintainers; [ offline rawkode ];
    license     = stdenv.lib.licenses.asl20;
    platforms   = platforms.unix;
  };
}
