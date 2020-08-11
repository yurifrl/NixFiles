{ config, lib, pkgs, environment, ... }:
with lib;
let
 cfg = config.yuri.programs.emacs;
in {
  options.yuri.programs.emacs = {
    enable = mkEnableOption "emacs enable";
    autostart = mkOption {
      type = with types; uniq bool;
      default = false;
      description = "
        emacs autostart
      ";
    };
  };

  config.environment.systemPackages = with pkgs; [
    emacs
  ];

  config.systemd = mkIf cfg.autostart {
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