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

      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users.yuri = {
        #shell = pkgs.fish;
        isNormalUser = true;
        extraGroups = [ "wheel" "docker" "networkmanager" ]; # Enable ‘sudo’ for the user.
      };

      home-manager.users.yuri = { pkgs, ... }: {
        programs = {
          home-manager = {
            enable = true;
          };
          tmux = {
            enable = true;
            extraConfig = builtins.readFile ./config/tmux.conf;
          };
          #fish = {
          #  enable = true;
          #};
          vim = {
            enable = true;
            extraConfig = builtins.readFile ./config/vim/config;
            plugins = [
              "vim-airline"
              "vim-commentary"
              "auto-pairs"
              "vim-surround"
            ];
          };
        };
        home = {
          file = {
            # config
            ".spacemacs" = {
              source = ./config/spacemacs;
            };
            ".Xresources" = {
              source = ./config/Xresources;
            };
            ".gitconfig" = {
              source = ./config/gitconfig;
            };
            ".ignore" = {
              source = ./config/ignore;
            };
            ".bin" = {
              source = ./config/bin;
            };
            # ".tmux.conf" = {
            #   source = ./config/tmux.conf;
            # };
            # ".xmodmap" = {
            #   source = ./config/xmodmap;
            # };
            # ".xinitrc" = {
            #   source = ./config/xinitrc;
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
              source = ./config/i3;
              target = ".config/i3";
              recursive = true;
            };
            # fish = {
            #   source = ./config/fish;
            #   target = ".config/fish";
            #   recursive = true;
            # };
            tmux = {
              source = ./config/tmux;
              target = ".config/tmux";
              recursive = true;
            };
            desktop = {
              source = ./config/applications;
              target = ".local/share/applications";
              recursive = true;
            };
          };
        };
      };
    }
