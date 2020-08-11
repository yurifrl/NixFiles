{ config, lib, pkgs, environment, ... }:

with lib;
let
 cfg = config.yuri.programs.chrome;
in {
  options.yuri.programs.chrome = {
    autostart = mkOption {
      type = with types; uniq bool;
      default = false;
      description = "
        chrome autostart
      ";
    };
  };

  config.environment.systemPackages = with pkgs; [
    google-chrome-beta
  ];

  config.systemd = mkIf cfg.autostart {
    user.services.chrome = {
      description = "Google Chrome";
      wantedBy = [ "graphical-session.target" "multi-user.target" "network-online.target" ];
      partOf = [ "graphical-session.target" ];
      after = [ "network-online.target" "network.target" "graphical-session.target" "graphical.target"];
      serviceConfig = {
        ExecStart = [
          """
          ${pkgs.i3}/bin/i3-msg 'workspace 2; exec ${pkgs.google-chrome-beta}/bin/google-chrome-beta'
          """
        ];
      };
    };
  };
}
