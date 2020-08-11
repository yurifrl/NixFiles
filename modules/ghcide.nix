# https://github.com/sociam/xray-archiver/blob/c7f57c43c6cc10a5feb55cc12d06a48bc5b95286/module.nix#L119
{ config, lib, pkgs, environment, ... }:

with lib;
with (import (builtins.fetchGit {
  name = "ghcide-for-nix";
  url = https://github.com/magthe/ghcide-for-nix;
  rev = "927a8caa62cece60d9d66dbdfc62b7738d61d75f";
}));
let
in {
  options.programs.ghcide = {
    enable = mkEnableOption "ghcide enable";
  };

  config.environment = mkIf config.programs.ghcide.enable {
    systemPackages = with pkgs; [
      ghcide
    ];
  };
}
