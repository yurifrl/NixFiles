# https://github.com/sociam/xray-archiver/blob/c7f57c43c6cc10a5feb55cc12d06a48bc5b95286/module.nix#L119
{ config, lib, pkgs, environment, ... }:

with lib;
let
  elixir-ls = pkgs.callPackage ../../pkgs/elixir-ls {};
  cfg = config.yuri.programs.elixir-ls;
in {
  options.yuri.programs.elixir-ls = {
    enable = mkEnableOption "elixir-ls enable";
  };

  config.environment.systemPackages = [
    elixir-ls pkgs.elixir
  ];
}
