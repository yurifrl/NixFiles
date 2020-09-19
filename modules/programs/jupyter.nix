{ config, lib, pkgs, services, ... }:

with lib;
let
  cfg = config.yuri.programs.jupyter;

  ihaskell = jupyter.kernels.iHaskellWith {
    name = "haskell";
    packages = p: with p; [ hvega formatting ];
  };

  go = jupyter.kernels.gophernotes {
    name = "gophernotes";
  };

  jupyter = import (builtins.fetchGit {
    url = https://github.com/tweag/jupyterWith;
    rev = "";
  }) {};

  jupyterEnvironment = jupyter.jupyterlabWith {
    kernels = [ ihaskell go ];
  };
in {
  config.environment.systemPackages = with pkgs; [
    jupyterEnvironment
  ];
}
