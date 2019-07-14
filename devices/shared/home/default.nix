{ config, pkgs, ... }:

with import <nixpkgs> {};
with builtins;
with lib;
{
  imports = [
        # Add home-manager module
        "${fetchGit {
          url = "https://github.com/rycee/home-manager";
          ref = "release-19.03";
        }}/nixos"
      ];

      home-manager.users.yuri = { pkgs, ... }: {
        programs = {
          vim = {
            enable = true;
            extraConfig = builtins.readFile ./files/vim/config;
            plugins = [
              "vim-airline"
              "vim-commentary"
              "auto-pairs"
              "vim-surround"
            ];
          };
        };
        home = {
          packages = with pkgs; [
            emacs
            # fish
            # tmux
            # git
          ];
          file = {
            # Files
            ".spacemacs" = {
              source = ./files/spacemacs;
            };
            ".gitconfig" = {
              source = ./files/gitconfig;
            };
            ".ignore" = {
              source = ./files/ignore;
            };
            ".tmux.conf" = {
              source = ./files/tmux.conf;
            };
            # ".xmodmap" = {
            #   source = ./files/xmodmap;
            # };
            # ".xinitrc" = {
            #   source = ./files/xinitrc;
            # };
            # Folders
            ".emacs.d" = {
              source = fetchGit {
                url = "https://github.com/syl20bnr/spacemacs";
                ref = "v0.200.13";
              };
              recursive = true;
            };
            i3 = {
              source = ./files/config/i3;
              target = ".config/i3";
              recursive = true;
            };
            fish = {
              source = ./files/config/fish;
              target = ".config/fish";
              recursive = true;
            };
            tmux = {
              source = ./files/config/tmux;
              target = ".config/tmux";
              recursive = true;
            };
            desktop = {
              source = ./files/local/share/applications;
              target = ".local/share/applications";
              recursive = true;
            };
          };
        };
      };
    }
