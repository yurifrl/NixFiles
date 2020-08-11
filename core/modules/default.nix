{ pkgs, lib, fetchurl, environment, services, ... }:

{
  imports = [
    ./blueman.nix
    ./certs.nix
    ./discord.nix
    ./emacs.nix
    ./parcellite.nix
    ./vscode.nix
    ./chrome.nix
  ];
}
