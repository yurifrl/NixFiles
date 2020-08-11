# https://github.com/sociam/xray-archiver/blob/c7f57c43c6cc10a5feb55cc12d06a48bc5b95286/module.nix#L119
{ config, lib, pkgs, environment, ... }:
with lib;
let
  xst = pkgs.callPackage ../../pkgs/xst {};
  cfg = config.yuri.programs.terminal;
in {
  options.yuri.programs.terminal = {
    autostart = mkOption {
      type = with types; uniq bool;
      default = false;
      description = "
        terminal autostart
      ";
    };
  };

  config.environment.systemPackages = [
    xst
  ];

  config.systemd = mkIf cfg.autostart {
    user.services.terminal = {
      description = "terminal";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = [ "${xst}/bin/xst" ];
      };
    };
  };
}
