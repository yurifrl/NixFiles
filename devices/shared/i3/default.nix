{ config, pkgs, ... }:


{
  services.xserver = {
    libinput.enable = true;
    enable = true;
    windowManager = {
      default = "i3";
      i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          i3status
          i3lock
          i3blocks
          acpi
          xclip
        ];
      };
    };
    desktopManager = {
      default = "none";
      xterm.enable = false;
    };
  };
}

