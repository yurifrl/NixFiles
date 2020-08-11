{ config, lib, pkgs, ... }:
with lib;
let
 cfg = config.yuri.programs.parcellite;
in {
  options.yuri.programs.parcellite = {
    enable = mkEnableOption "parcellite enable";
    autostart = mkOption {
      type = with types; uniq bool;
      default = false;
      description = "
        parcellite autostart
      ";
    };
  };

  config.environment.systemPackages = with pkgs; [
    parcellite
  ];

  config.systemd = mkIf cfg.autostart {
    user.services.parcellite = {
      description = "parcellite autostart";
      wantedBy = [ "graphical-session.target" ];
      after = ["status-notifier-watcher.service" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig.ExecStart = [ "${pkgs.parcellite}/bin/parcellite" ];
    };
  };
}