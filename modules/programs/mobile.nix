# https://github.com/sociam/xray-archiver/blob/c7f57c43c6cc10a5feb55cc12d06a48bc5b95286/module.nix#L119
# https://github.com/ericdallo/dotfiles/blob/master/nix/configurations/dev.nix
# https://nixos.org/manual/nixpkgs/stable/#deploying-an-android-sdk-installation-with-plugins
# https://github.com/nbacquey/custom-nixpkgs/blob/master/pkgs/development/mobile/androidenv/compose-android-packages.nix
{ stdenv, fetchFromGitHub, pkgs, ... }:

let
  android = pkgs.androidenv.composeAndroidPackages {
    platformVersions = [ "28" ];
    includeEmulator = true;
    includeSystemImages = true;
    systemImageTypes = [ "default" ];
    abiVersions = [ "x86" "x86_64"];
    includeSources = true;
    toolsVersion = "25.2.5";
    emulatorVersion = "30.0.3";
    useGoogleAPIs = true;
    useGoogleTVAddOns = true;
  };
  android-sdk-path = "${android.androidsdk}/libexec/android-sdk";
in {
  nixpkgs.config.android_sdk.accept_license = true;

  environment = {
    variables = {
      FLUTTER_SDK = "${pkgs.flutter.unwrapped}";
      # ANDROID_SDK_ROOT = android-sdk-path;
      # ANDROID_HOME = android-sdk-path;
      ANDROID_JAVA_HOME = "${pkgs.adoptopenjdk-jre-openj9-bin-11.home}";
      ANDROID_HOME="$HOME/Android/Sdk";
      ANDROID_SDK_ROOT="$HOME/Android/Sdk";
    };
    systemPackages = with pkgs; [
      flutter
      android-studio
      android.androidsdk
      adoptopenjdk-jre-openj9-bin-11
      xorg.libXtst
    ];
  };

  programs.adb.enable = true;

  boot.kernelModules = [ "kvm-amd" ];
  virtualisation.libvirtd.enable = true;

  users.users.yuri = {
    extraGroups = [ "adbusers" ];
  };
  services.udev.packages = [
    pkgs.android-udev-rules
  ];
}
