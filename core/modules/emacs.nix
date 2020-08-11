{ config, lib, pkgs, environment, ... }:
with lib;
{
  options.programs.emacs = {
    enable = mkEnableOption "emacs enable";
    autostart = mkOption {
      type = with types; uniq bool;
      default = true;
      description = "
        emacs autostart
      ";
    };
  };

  config.environment = mkIf config.programs.emacs.enable {
    systemPackages = with pkgs; [
      emacs
    ];
  };

  config.systemd = mkIf config.programs.emacs.autostart {
    user.services.emacs = {
      description = "Emacs autstart";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "taffybar.service" ];
      after = ["status-notifier-watcher.service" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig.ExecStart = [ "${pkgs.emacs}/bin/emacs" ];
    };
  };
}