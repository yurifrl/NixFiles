# Edit thi/ configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
# Check for options https://nixos.org/nixos/options.html#

{ config, pkgs, ... }:

with (import (builtins.fetchGit {
  name = "ghcide-for-nix";
  url = https://github.com/magthe/ghcide-for-nix;
  rev = "927a8caa62cece60d9d66dbdfc62b7738d61d75f";
}));
let
  # Unstable packages
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
  # Envs
  homedir = builtins.getEnv "HOME";
  # My Packages
  krew = pkgs.callPackage ../pkgs/krew {};
  xst = pkgs.callPackage ../pkgs/xst {};
  kind = pkgs.callPackage ../pkgs/kind {};
  tilt = pkgs.callPackage ../pkgs/tilt {};
  kubeseal = pkgs.callPackage ../pkgs/kubeseal {};
  kustomize = pkgs.callPackage ../pkgs/kustomize {};
  kubebuilder = pkgs.callPackage ../pkgs/kubebuilder {};
  mydiscord = pkgs.callPackage ../pkgs/discord {};
in {
  imports = [
    ./home
    ./secrets
    ./modules
  ];

  nix = {
    trustedUsers = [ "root" "yuri" "yuri.lima"];
    envVars = {
      NIX_GITHUB_PRIVATE_USERNAME = "";
      NIX_GITHUB_PRIVATE_PASSWORD = "";
    };
  };

  environment = {
    variables = {
      EDITOR = "/home/yuri/.nix-profile/bin/vim";
      TERMINAL = "xst";
      SHELL = "fish";
    };

    # For batery
    pathsToLink = [ "/libexec" ];

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      # killall: use pkill -f
      mydiscord
      kubeseal
      ag
      arandr
      arduino
      argocd
      audacity
      awscli
      bazel
      bind
      brightnessctl
      charles4
      containerd
      docker
      docker-compose
      eksctl
      emacs
      ffmpeg
      firefox
      ghcide
      git
      gitAndTools.diff-so-fancy
      gnumake
      google-chrome-beta
      htop
      inetutils
      jq
      k3s
      k9s
      kbfs
      keybase-go
      kind
      krew
      kubebuilder
      kubectl
      kubernetes-helm
      kustomize
      lazygit
      meld
      minikube
      networkmanager-openconnect
      networkmanager-openvpn
      networkmanagerapplet
      ngrok
      nix-prefetch
      nix-prefetch-git
      nmap
      nmap-graphical
      nodejs
      obs-studio
      openconnect
      openssl
      parcellite # Manages clipboard sync
      pavucontrol
      pulsemixer
      python3
      ranger
      sbt
      sdl-jstest
      shutter
      smbclient
      stack
      steam
      steam-run
      tilt
      unity3d
      unstable.adoptopenjdk-jre-openj9-bin-11
      # unstable.discord-ptb
      unstable.fish
      unstable.go
      unstable.gotools
      unstable.gradle
      unstable.metals
      unstable.pbis-open
      unstable.tmux
      unzip
      vgo2nix
      vim
      vlc
      wget
      wirelesstools
      xorg.xev
      xorg.xhost
      xorg.xprop
      xorg.xwininfo
      xst
      youtube-dl
      zoom-us
    ];
  };

  nixpkgs.config = {
    allowBroken = true;
    allowUnfree = true;
    # This is for openconnect
    permittedInsecurePackages = [
      "openssl-1.0.2u"
    ];
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  # Network
  networking.networkmanager.enable = true;

  # Don't require sudo for brigthnessctl
  security = {
    # sudo.enable = true;
    sudo.extraRules = [{
      runAs = "root";
      groups = [ "wheel" ];
      commands = [{
        command = "/run/current-system/sw/bin/brightnessctl";
        options = [ "NOPASSWD" ];
      }];
    }];
  };

  # Sound and Bluetooth
  hardware = {
    pulseaudio = {
      enable = true;
      # NixOS allows either a lightweight build (default) or full build of PulseAudio to be installed.
      # Only the full build has Bluetooth support, so it must be selected here.
      package = pkgs.pulseaudioFull;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
      extraConfig = ''
        load-module module-bluetooth-policy auto_switch=2
      '';
    };
    bluetooth = {
      enable = true;
      # extraConfig = "
      #   [General]
      #   Enable=Source,Sink,Media,Socket
      # ";
      package = pkgs.bluezFull;
      config = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };

  # Enable sound.
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  # Enable Docker
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;

  # location
  location = {
    latitude = -23.502428;
    longitude = -46.626527;
  };

  # List services that you want to enable:
  services = {
    resolved.enable = true;
    # Allow access to USB devices without requiring root permissions
    udev.extraRules = ''
      # SR V4 power board
      SUBSYSTEM=="usb", ATTR{idVendor}=="1bda", ATTR{idProduct}=="0010", GROUP="dialout", MODE="0666"
      # SR V4 servo board
      SUBSYSTEM=="usb", ATTR{idVendor}=="1bda", ATTR{idProduct}=="0011", GROUP="dialout", MODE="0666"
      # Altera "USB Blaster" JTAG cable
      SUBSYSTEM=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6001", GROUP="dialout", MODE="0666"
    '';

    logind.lidSwitch = "ignore";

    # https://github.com/vidbina/nixos-configuration
    # http://vid.bina.me/config/mediabuttons-nixos-dell-xps/
    # https://nixos.wiki/wiki/Actkbd
    actkbd = {
      enable = true;
      bindings = [
        { keys = [ 224 ]; events = [ "key" ]; command = "brightnessctl s 30%-"; }
        { keys = [ 225 ]; events = [ "key" ]; command = "brightnessctl s +30"; }
      ];
    };

    redshift = {
      enable = true;
      brightness = {
        day = "1";
        night = "1";
      };
      temperature = {
        # temperature.day = 6500;
        # temperature.night = 2700;
      };
    };

    # It's for auto detecting external monitor and scripts for that
    # It seams that a hard restart fixes it https://forum.manjaro.org/t/hdmi-shows-disconnected-in-xrandr/113606/3
    autorandr.enable = true;

    # It's for battery i suppose
    acpid.enable = true;

    #
    blueman.enable = true;

    # Enable the OpenSSH daemon.
    openssh.enable = true;

    keybase = {
      enable = true;
    };

    kbfs = {
      enable = true;
      mountPoint = "%h/Keybase";
    };

    xserver = {
      imwheel = {
        # enable = true;
        # ## https://github.com/turboMaCk/Dotfiles/blob/9bfb7c098cd7290bfea6713f52ff1c2d3d2edb1c/nixos/machines/desktop.nix#L133
        # # Shift_L,   Up,   Shift_L|Button4, 4
        # # Shift_L,   Down, Shift_L|Button5, 4
        # # Control_L, Up,   Control_L|Button4
        # # Control_L, Down, Control_L|Button5
        # rules = {
        #     ".*" = ''
        #     None,      Up,   Button4, 3
        #     None,      Down, Button5, 3
        #     '';
        # };
      };
      ## if I want to add programmers devorak
      ## http://stesie.github.io/2016/08/nixos-custom-keyboard-layout
      # Keyboard config
      layout = "us,br";
      # https://askubuntu.com/questions/445099/whats-the-opposite-of-setxkbmap-option-ctrlnocaps
      # xkbOptions = "ctrl:nocaps, seurosign:e, compose:menu, grp:alt_space_toggle";
      xkbOptions = "ctrl:nocaps,grp:alt_space_toggle,compose:ralt";

      ## Nice sample cofig with options set here https://github.com/danielfullmer/nixos-config/blob/master/profiles/desktop/default.nix
      displayManager.defaultSession = "none+i3";
      enable = true;
      autorun = true;
      libinput = {
        enable = true;
        # This seams to enable natural scrolling
        naturalScrolling = false;
        tapping =  false;
        accelProfile = "flat";
      };
      exportConfiguration = true;
      # AccelSeepd Does the trick for mouse speed
      config = ''
        Section "InputClass"
          Identifier "Mx Ergo"
          MatchIsPointer "true"
          MatchProduct "Ergo|Mouse"
          Driver "libinput"
          Option "AccelSpeed" "0.4"
          Option "AccelerationThreshold"   "0"
          Option "AccelerationNumerator"   "4"
          Option "AccelerationDenominator" "2"
          Option "Coordinate Transformation Matrix" "1 0 0 0 1 0 0 0 .6"
        EndSection
      '';

      windowManager = {
        i3 = {
          enable = true;
          extraPackages = with pkgs; [
            dmenu
            i3status
            i3lock
            i3blocks
            acpi
            xclip
            xsel
          ];
          # Keychain
          extraSessionCommands = ''
            eval $(gnome-keyring-daemon --daemonize)
            export SSH_AUTH_SOCK
          '';
        };
      };

      # Install xfce as desktop manager because i3 does not manages windows?
      # https://nixos.wiki/wiki/I3
      desktopManager = {
        xterm.enable = false;
        xfce = {
          enable = false;
          noDesktop = true;
          enableXfwm = false;
        };
      };
    };

    # Keychain
    gnome3.gnome-keyring.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    groups = {
      "domain users" = {
        members = [ "yuri" "yuri.lima" ];
      };
    };
    users = {
      yuri = {
        isNormalUser = true;
        extraGroups = [ "wheel" "docker" "networkmanager" "audio" "dialout" ]; # Enable ‘sudo’ for the user.
        initialHashedPassword = "change";
      };
      "yuri.lima" = {
        isNormalUser = true;
        extraGroups = [ "wheel" "docker" "networkmanager" "audio" "dialout" ]; # Enable ‘sudo’ for the user.
        initialHashedPassword = "change";
      };
    };
  };

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Fonts
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      noto-fonts-emoji
      symbola
      powerline-fonts
      source-code-pro
      fira-code
      fira-mono
      fira-code-symbols
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {
    # Keychain
    seahorse.enable = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      enableBrowserSocket = true;
      enableExtraSocket = true;
    };
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8888 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;
  # /etc/hosts
  # networking.extraHosts = ''
  # '';
}
