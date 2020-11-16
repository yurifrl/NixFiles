{ config, lib, pkgs, services, ... }:

with lib;
let
  espIdf = pkgs.callPackage ./esp-idf.nix {};
  esp32Toolchain  = pkgs.callPackage ./esp32-toolchain.nix {};

in {
  config.environment.systemPackages = with pkgs; [
    espIdf
    esp32Toolchain
  ];
}
