# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

# Current in use
{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ./hardware-configuration.nix
    ../../core
  ];
  networking.hostName = "dft-sp-wkn763";
  boot = {
    # My Legacy Boot
    initrd.luks.devices = {
      boot = {
        device = "/dev/sda2";
        preLVM = true;
      };
    };

    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    loader.grub.efiSupport = true;
    loader.grub.efiInstallAsRemovable = true;
    loader.efi.efiSysMountPoint = "/boot";
    # Define on which hard drive you want to install Grub.
    loader.grub.device = "nodev"; # or "nodev" for efi only
  };
}
