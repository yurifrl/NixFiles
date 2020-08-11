# https://github.com/rycee/home-manager/blob/master/modules/services/blueman-applet.nix
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/programs/nm-applet.nix
# https://nixos.wiki/wiki/Module
# https://github.com/sociam/xray-archiver/blob/c7f57c43c6cc10a5feb55cc12d06a48bc5b95286/module.nix#L119
{ config, lib, pkgs, services, ... }:

with lib;

{
  options.programs.blueman = {
    enable = mkEnableOption "blueman-applet enable";
    autostart = mkOption {
      type = with types; uniq bool;
      default = true;
      description = "
        blueman-applet autostart
      ";
    };
  };

  config.services = mkIf config.programs.blueman.enable {
    blueman.enable = true;
  };

  config.systemd = mkIf config.programs.blueman.autostart {
    user.services.blueman = {
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      after = ["status-notifier-watcher.service" ];
      serviceConfig.ExecStart = [
        "${pkgs.blueman}/bin/blueman-applet"
      ];
    };
  };
}
