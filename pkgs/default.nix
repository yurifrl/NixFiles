{ pkgs ? import <nixpkgs> { }, ... }:

{
  arma3-unix-launcher = pkgs.callPackage ./arma3-unix-launcher { };
  dftech-tools = pkgs.callPackage ./dftech-tools { };
  discord = pkgs.callPackage ./discord { };
  kconf = pkgs.callPackage ./kconf { };
  kind = pkgs.callPackage ./kind { };
  krew = pkgs.callPackage ./krew { };
  kubebuilder = pkgs.callPackage ./kubebuilder { };
  kubeseal = pkgs.callPackage ./kubeseal { };
  kustomize = pkgs.callPackage ./kustomize { };
  nordvpn = pkgs.callPackage ./nordvpn { };
  obs-v4l2sink = pkgs.callPackage ./obs-v4l2sink { };
  tilt = pkgs.callPackage ./tilt { };
  xst = pkgs.callPackage ./xst { };
  zoom = pkgs.callPackage ./zoom { };
  k8slens = pkgs.callPackage ./k8slens { };
  kubectl = pkgs.callPackage ./kubectl { };
  androidsdk = pkgs.callPackage ./androidsdk { };
  argocd = pkgs.callPackage ./argocd { };
  okteto = pkgs.callPackage ./okteto { };
  kubefwd = pkgs.callPackage ./kubefwd { };
}