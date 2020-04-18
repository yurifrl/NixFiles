# # !!! This file belongs to the yarn framework. !!!
# # !!! Do not change unless you know what you're doing. !!!

let
  # This function takes the path of a device module as an argument
  # and returns a complete module to be imported in configuration.nix
  makeDevice = devicePath: { config, pkgs, lib, ... }: {
    imports = [
      devicePath
      #./cachix.nix
    ];
    #
    system.stateVersion = "19.09";
    system.autoUpgrade.enable = true;
    boot = {
      # Need for mon-2-cam script
      extraModulePackages = [ config.boot.kernelPackages.broadcom_sta
                              config.boot.kernelPackages.v4l2loopback
                            ];

      # https://github.com/NixOS/nixpkgs/issues/25490
      # https://www.reddit.com/r/RetroPie/comments/bi5bm4/psa_new_method_for_disabling_ertm_fix_controller/
      # https://github.com/baracoder/nix/blob/master/configuration.nix
      # https://www.reddit.com/r/NixOS/comments/a7g4oi/declaratively_setting_sysfs_properties/
      # https://nixos.org/nixos/options.html#kernel.sysctl
      extraModprobeConfig = '' options bluetooth disable_ertm=1 '';
      # blacklistedKernelModules = ["xpad"];
      # kernelParams = [
      #   "bluetooth.disable_ertm=1"
      # ];
      # kernel.sysctl = {
      #   "bluetooth.disable_ertm" = 1;
      # };
      # kernelModules = [ "uinput" ];
    };
    # Needed for steam
    hardware.opengl.driSupport32Bit = true;
    hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    hardware.pulseaudio.support32Bit = true;
  };

  deviceModules =
    builtins.listToAttrs (map (deviceName: {
      name = deviceName;
      value = makeDevice (./devices + "/${deviceName}");
    }) (import ./devices/all-devices.nix));
in deviceModules
