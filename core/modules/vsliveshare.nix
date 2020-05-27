{ pkgs, ... }:

{
  imports = [
    (fetchTarball "https://github.com/msteen/nixos-vsliveshare/tarball/master")
  ];

  #services.gnome-keyring.enable = true;

  services.vsliveshare = {
    enable = true;
    extensionsDir = "$HOME/.vscode/extensions";
    nixpkgsPath = builtins.fetchGit {
      url = "https://github.com/NixOS/nixpkgs.git";
      ref = "refs/heads/nixos-20.03";
      rev = "61cc1f0dc07c2f786e0acfd07444548486f4153b";
    };
  };
}
