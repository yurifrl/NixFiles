{ config, lib, pkgs, services, ... }:

# https://github.com/tweag/jupyterWith
# https://github.com/shitikovkirill/NixConfDevServer/blob/master/programmin/jupyter/service/default.nix
with lib;
let
  cfg = config.yuri.programs.jupyter;

  jupyter = import (builtins.fetchGit {
    url = https://github.com/tweag/jupyterWith;
    rev = "";
  }) {};

  ihaskell = jupyter.kernels.iHaskellWith {
    name = "haskell";
    packages = p: with p; [ hvega formatting ];
  };

  go = jupyter.kernels.gophernotes {
    name = "gophernotes";
  };

  myKernels = pkgs.callPackage ./kernels {};

  jupyterEnvironment = jupyter.jupyterlabWith {
    kernels = [ ihaskell go (myKernels.java {}) ];
  };
in {
  config.environment.systemPackages = with pkgs; [
    jupyterEnvironment
    python38Packages.ipykernel
  ];
  # config.services.jupyter = {
  #   enable = true;
  #   password = "password";
  # };
}
