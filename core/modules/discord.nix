{ config, lib, pkgs, environment, ... }:
# https://github.com/sociam/xray-archiver/blob/c7f57c43c6cc10a5feb55cc12d06a48bc5b95286/module.nix#L119
with lib;
let
  discord = pkgs.callPackage ../../pkgs/discord {};
in {
  options.programs.discord = {
    enable = mkEnableOption "discord enable";
    autostart = mkOption {
      type = with types; uniq bool;
      default = true;
      description = "
        discord autostart
      ";
    };
  };

  config.environment = mkIf config.programs.discord.enable {
    systemPackages = with pkgs; [
      discord
    ];
  };

  config.systemd = mkIf config.programs.discord.autostart {
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
