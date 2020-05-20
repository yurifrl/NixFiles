{ lib, stdenv, fetchurl }:

stdenv.mkDerivation rec {
  owner = "kubernetes-sigs";
  name = "kubebuilder";
  version = "2.3.1";

  src = fetchurl {
    url = "https://github.com/${owner}/${name}/releases/download/v${version}/${name}_${version}_linux_amd64.tar.gz";
    sha256 = "047dljgba5q1g6sp5fdkhl0d1s1dzk7bv8mby9infw09y9q6jjgz";
  };
  setSourceRoot = "sourceRoot=`pwd`";
  installPhase = ''
    mv kubebuilder_2.3.1_linux_amd64/bin/* .
    install -Dm755 "kubebuilder" -t "$out/bin"
    install -Dm755 "etcd" -t "$out/bin"
    install -Dm755 "kube-apiserver" -t "$out/bin"
  '';

  meta = with lib; {
    description = "Create kubernetes controllers";
    longDescription = ''
    '';
    homepage = "https://github.com/kubernetes-sigs/kubebuilder";
    license = licenses.asl20;
    maintainers = with maintainers; [ yurifrl ];
  };
}
