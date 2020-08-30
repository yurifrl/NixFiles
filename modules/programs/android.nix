# https://github.com/sociam/xray-archiver/blob/c7f57c43c6cc10a5feb55cc12d06a48bc5b95286/module.nix#L119
# https://github.com/ericdallo/dotfiles/blob/master/nix/configurations/dev.nix
{ stdenv, fetchFromGitHub, pkgs, ... }:

let
  android = pkgs.androidenv.composeAndroidPackages {
    toolsVersion = "25.2.5";
    platformToolsVersion = "29.0.6";
    buildToolsVersions = [ "28.0.3" ];
    includeEmulator = true;
    emulatorVersion = "30.0.3";
    platformVersions = [];
    includeSources = false;
    includeDocs = false;
    includeSystemImages = false;
    systemImageTypes = [ "default" ];
    abiVersions = [ "armeabi-v7a" ];
    lldbVersions = [ ];
    cmakeVersions = [ ];
    includeNDK = false;
    ndkVersion = "21.0.6113669";
    useGoogleAPIs = false;
    useGoogleTVAddOns = false;
  };
  android-sdk-path = "${android.androidsdk}/libexec/android-sdk";
in {
  nixpkgs.config.android_sdk.accept_license = true;

  environment = {
    variables = {
      ANDROID_SDK_ROOT = android-sdk-path;
      ANDROID_HOME = android-sdk-path;
    };
    systemPackages = with pkgs; [
      android-studio
      android.androidsdk
    ];
  };
}
