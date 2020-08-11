{ config, lib, pkgs, ... }:
with lib;
{
  options.programs.parcellite = {
    enable = mkEnableOption "parcellite enable";
    autostart = mkOption {
      type = with types; uniq bool;
      default = true;
      description = "
        parcellite autostart
      ";
    };
  };

  config.environment = mkIf config.programs.parcellite.enable {
    systemPackages = with pkgs; [
      parcellite
    ];
  };

  config.systemd = mkIf config.programs.parcellite.autostart {
    user.services.parcellite = {
      description = "parcellite autostart";
      wantedBy = [ "graphical-session.target" ];
      after = ["status-notifier-watcher.service" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig.ExecStart = [ "${pkgs.parcellite}/bin/parcellite" ];
    };
  };
}