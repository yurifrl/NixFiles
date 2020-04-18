{ config, pkgs, ... }:

# https://github.com/NixOS/nixpkgs/issues/25490
# https://www.reddit.com/r/RetroPie/comments/bi5bm4/psa_new_method_for_disabling_ertm_fix_controller/
# https://github.com/baracoder/nix/blob/master/configuration.nix
# https://www.reddit.com/r/NixOS/comments/a7g4oi/declaratively_setting_sysfs_properties/
# https://nixos.org/nixos/options.html#kernel.sysctl
# https://github.com/timor/timor-overlay/blob/d49783d2880b730cd67dbe6700ea2968f893b32e/modules/xbox360-wireless.nix
# https://github.com/phildenhoff/pd/blob/44025561b223df9901e4415650deae08b1077865/dotfiles/entertainment.nix
{
  environment.systemPackages = [ pkgs.xboxdrv ];

  boot.blacklistedKernelModules = [ "xpad" ];

  environment.etc."default/xboxdrv".text = ''
    [xboxdrv]
    silent = true
    device-name = "Xbox 360 Wireless Receiver"
    mimic-xpad = true
    deadzone = 4000
    [xboxdrv-daemon]
    dbus = disabled
  '';

  systemd.services.xboxdrv = {
    description = "Xbox/Xbox360 USB Gamepad Driver for Userspace";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.xboxdrv}/bin/xboxdrv --daemon --config /etc/default/xboxdrv
      '';
      RestartSec = 3;
      Restart = "always";
    };
  };
}