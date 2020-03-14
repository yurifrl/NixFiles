# # !!! This file belongs to the yarn framework. !!!
# # !!! Do not change unless you know what you're doing. !!!

let
  # This function takes the path of a device module as an argument
  # and returns a complete module to be imported in configuration.nix
  makeDevice = devicePath: { config, pkgs, lib, ... }:

  {
    imports = [
      devicePath
      #./cachix.nix
    ];

    system.stateVersion = "19.09";
    system.autoUpgrade.enable = true;
  };
  deviceModules =
    builtins.listToAttrs (map (deviceName: {
      name = deviceName;
      value = makeDevice (./devices + "/${deviceName}");
    }) (import ./devices/all-devices.nix));
in deviceModules
