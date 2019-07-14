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
        file = {
        # config
        # ".spacemacs" = {
        #   source = ./config/spacemacs;
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
        ".bin" = {
          source = ./config/bin;
        };
        ".tmux.conf" = {
          source = ./config/tmux.conf;
        };
        # ".xmodmap" = {
        #   source = ./config/xmodmap;
        # };
        # ".xinitrc" = {
        #   source = ./config/xinitrc;
        # };
        # Folders
        ".tmux/plugins" = {
          source = fetchGit {
            url = "https://github.com/tmux-plugins/tpm";
            ref = "tags/v2.0.0";
            rev = "35161668d986d83c46cdcf870cfc549431db9f8f";
          };
          recursive = true;
        };
        # ".emacs.d" = {
        #   source = fetchGit {
        #     url = "https://github.com/syl20bnr/spacemacs";
        #     ref = "v0.200.13";
        #   };
        #   recursive = true;
        # };
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
        ".config/fish/functions" = {
          source = ./config/fish/functions;
          recursive = true;
        };
        ".config/fish/config" = {
          source = ./config/fish/config;
          recursive = true;
        };
      };
    };
  };
}
