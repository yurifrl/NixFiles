# https://github.com/sociam/xray-archiver/blob/c7f57c43c6cc10a5feb55cc12d06a48bc5b95286/module.nix#L119
{ config, lib, pkgs, environment, ... }:
with lib;
let
  discord = pkgs.callPackage ../../pkgs/discord {};
  cfg = config.yuri.programs.discord;
in {
  options.yuri.programs.discord = {
    enable = mkEnableOption "discord enable";
    autostart = mkOption {
      type = with types; uniq bool;
      default = false;
      description = "
        discord autostart
      ";
    };
  };

  config.environment.systemPackages = [
    discord
  ];

  config.systemd = mkIf cfg.autostart {
    user.services.discord = {
      description = "Discord";
      wantedBy = [ "graphical-session.target" "multi-user.target" "network-online.target" ];
      partOf = [ "graphical-session.target" ];
      after = [ "network-online.target" "network.target" ];
      environment = {
        COOL = "yes";
      };
      serviceConfig = {
        Restart = "always";
        ExecStart = [ "${discord}/bin/Discord" ];
      };
    };
  };
}
