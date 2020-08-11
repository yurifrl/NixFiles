{ config, lib, pkgs, environment, ... }:

with lib;
{
  options.programs.chrome = {
    enable = mkEnableOption "chrome enable";
    autostart = mkOption {
      type = with types; uniq bool;
      default = true;
      description = "
        chrome autostart
      ";
    };
  };

  config.environment = mkIf config.programs.chrome.enable {
    systemPackages = with pkgs; [
      google-chrome-beta
    ];
  };

  config.systemd = mkIf config.programs.chrome.autostart {
    user.services.chrome = {
      description = "Google Chrome";
      wantedBy = [ "graphical-session.target" "multi-user.target" "network-online.target" ];
      partOf = [ "graphical-session.target" ];
      after = [ "network-online.target" "network.target" ];
      serviceConfig = {
        ExecStart = [ "${pkgs.i3}/bin/i3-msg 'workspace 2; ${pkgs.google-chrome-beta}/bin/google-chrome-beta'" ];
      };
    };
  };
}
