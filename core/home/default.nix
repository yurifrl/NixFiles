{ config, pkgs, ... }:

with import <nixpkgs> {};
with builtins;
with lib;
let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    ref = "release-19.03";
  };
  dag = import "${home-manager}/modules/lib/dag.nix" {
    inherit lib;
  };
in
{
  imports = [
    # Add home-manager module
    (import "${home-manager}/nixos")
  ];

  home-manager.users.yuri = { pkgs, ... }: {
    programs = {
      vim = {
        enable = true;
        extraConfig =
          (builtins.readFile ./config/vim/config) +
          (builtins.readFile ./config/vim/keybindings);
          plugins = [
            "vim-airline"
            "vim-commentary"
            "auto-pairs"
            "vim-surround"
          ];
        };
      };
      home = {
        activation.createLinks = dag.dagEntryAfter ["writeBoundary"] ''
           ln -sfn $HOME/NixFiles/core/home/config/spacemacs $HOME/.spacemacs
           ln -sfn $HOME/NixFiles/core/home/config/bin $HOME/.bin
        '';
        file = {
          # ".spacemacs" = {
          #   source = ./config/spacemacs;
          # };
          # ".bin" = {
          #   source = ./config/bin;
          # };
          ".Xresources" = {
            source = ./config/Xresources;
          };
          ".gitconfig" = {
            source = ./config/gitconfig;
          };
          ".ignore" = {
            source = ./config/ignore;
          };
          ".tmux.conf" = {
            source = ./config/tmux.conf;
          };
        # Folders
        ".tmux/plugins" = {
          source = fetchGit {
            url = "https://github.com/tmux-plugins/tpm";
            ref = "tags/v2.0.0";
            rev = "35161668d986d83c46cdcf870cfc549431db9f8f";
          };
          recursive = true;
        };
        ".emacs.d" = {
          source = fetchGit {
            url = "https://github.com/syl20bnr/spacemacs";
            ref = "develop";
          };
          recursive = true;
        };
        ".local/share/applications" = {
          source = ./config/applications;
          recursive = true;
        };
        ".config/i3" = {
          source = ./config/i3;
          recursive = true;
        };
        ".config/fish/config.fish" = {
          source = ./config/fish/config.fish;
        };
        ".config/fish/config" = {
          source = ./config/fish/config;
          recursive = true;
        };
      };
    };
  };
}
