# Edit thi/ configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
# Check for options https://nixos.org/nixos/options.html#

{ config, pkgs, ... }:

let
  # Envs
  homedir = builtins.getEnv "HOME";
  # Modules
  modules = import ../modules;
  myCustomLayout = pkgs.writeText "xkb-layout" ''
    keycode 166=
  '';
in {
  imports = [
    ./home
    modules.blueman
    modules.certs
    modules.chrome
    modules.discord
    modules.emacs
    modules.ghcide
    modules.parcellite
    modules.terminal
    modules.vscode
    modules.mobile
    modules.jupyter
    modules.elixir-ls
    modules.esp-idf
  ];

  yuri.programs = {
    parcellite.autostart = true;
    discord.autostart = true;
    blueman.autostart = true;
    # TODO: Chrome, cant open with i3 so I can redirect to workspace 2
    # TODO: Terminal wont open
    # TODO: Monitor script
  };

  nix = {
    trustedUsers = [ "root" "yuri" "yuri.lima"];
    allowedUsers = [ "root" "yuri" "yuri.lima"];
    envVars = {
      NIX_GITHUB_PRIVATE_USERNAME = "";
      NIX_GITHUB_PRIVATE_PASSWORD = "";
    };
  };

  nixpkgs.config = {
    allowBroken = true;
    allowUnfree = true;
    vivaldi = {
      proprietaryCodecs = true;
      enableWideVine = true;
    };
    # This is for openconnect
    permittedInsecurePackages = [
      "openssl-1.0.2u"
    ];
    packageOverrides = pkgs: {
      yuri = pkgs.callPackage ../pkgs {};
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
      # audacity
      # awscli
      # flutter
      # killall: use pkill -f
      # kubectl
      # unity3d
      # yuri.awscli
      helmsman
      terraform
      adoptopenjdk-jre-openj9-bin-11
      ag
      arandr
      arduino
      python27Packages.pyserial
      aws-iam-authenticator
      bazel
      bind
      brightnessctl
      charles4
      containerd
      docker
      docker-compose
      eksctl
      ffmpeg
      firefox
      fish
      flameshot # screenshot
      git
      git-hub
      gitAndTools.diff-so-fancy
      gitAndTools.gitui
      gnumake
      go
      google-chrome-beta
      google-cloud-sdk
      gotools
      gradle
      htop
      inetutils
      jq
      k3s
      k9s
      kbfs
      keybase-go
      kubernetes-helm
      meld
      metals
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
      pavucontrol
      pbis-open
      perl
      podman
      podman-compose
      pulsemixer
      python3
      ranger
      remmina
      sbt
      sdl-jstest
      shutter
      smbclient
      stack
      steam
      steam-run
      telepresence
      tightvnc
      tmux
      unzip
      vgo2nix
      vim
      vlc
      wget
      wirelesstools
      xorg.xev
      xorg.xhost
      xorg.xmodmap
      xorg.xprop
      xorg.xwininfo
      youtube-dl
      yuri.argocd
      yuri.k8slens
      yuri.kind
      yuri.krew
      yuri.kubebuilder
      yuri.kubectl
      yuri.kubefwd
      yuri.kubeseal
      yuri.kustomize
      yuri.okteto
      yuri.parsec
      yuri.tilt
      yuri.xst
      zoom-us
    ];
  };

  # Don't require sudo for brigthnessctl
  security = {
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
    # For arduino
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
        { keys = [ 232 ]; events = [ "key" ]; command = "brightnessctl s 30%-"; }
        { keys = [ 233 ]; events = [ "key" ]; command = "brightnessctl s +30"; }
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
      # imwheel = {
      #   enable = true;
      #   ## https://github.com/turboMaCk/Dotfiles/blob/9bfb7c098cd7290bfea6713f52ff1c2d3d2edb1c/nixos/machines/desktop.nix#L133
      #   # Shift_L,   Up,   Shift_L|Button4, 4
      #   # Shift_L,   Down, Shift_L|Button5, 4
      #   # Control_L, Up,   Control_L|Button4
      #   # Control_L, Down, Control_L|Button5
      #   rules = {
      #       ".*" = ''
      #       None,      Up,   Button4, 3
      #       None,      Down, Button5, 3
      #       '';
      #   };
      # };
      ## if I want to add programmers devorak
      ## http://stesie.github.io/2016/08/nixos-custom-keyboard-layout
      # Keyboard config
      layout = "us,br";
      # https://askubuntu.com/questions/445099/whats-the-opposite-of-setxkbmap-option-ctrlnocaps
      # xkbOptions = "ctrl:nocaps, seurosign:e, compose:menu, grp:alt_space_toggle";
      xkbOptions = "ctrl:nocaps,grp:alt_space_toggle,compose:ralt";

      ## Nice sample cofig with options set here https://github.com/danielfullmer/nixos-config/blob/master/profiles/desktop/default.nix
      displayManager = {
        sessionCommands = "${pkgs.xorg.xmodmap}/bin/xmodmap ${myCustomLayout}";
        defaultSession = "none+i3";
      };
      enable = true;
      autorun = true;
      libinput = {
        enable = true;
        # This seams to enable natural scrolling
        naturalScrolling = false;
        tapping =  false;
        # accelProfile = "flat";
        accelSpeed = "0.3";
        # additionalOptions = ''
        #   Option "AccelerationThreshold"   "0"
        #   Option "AccelerationNumerator"   "3"
        #   Option "AccelerationDenominator" "2"
        #   Option "Coordinate Transformation Matrix" "1 0 0 0 1 0 0 0 .6"
        # '';
      };
      # exportConfiguration = true;
      # AccelSeepd Does the trick for mouse speed
      # config = ''
      #   Section "InputClass"
      #     Identifier "Mx Ergo"
      #     MatchIsPointer "true"
      #     MatchProduct "Ergo|Mouse"
      #     Driver "libinput"
      #     Option "AccelSpeed" "0.4"
      #     Option "AccelerationThreshold"   "0"
      #     Option "AccelerationNumerator"   "4"
      #     Option "AccelerationDenominator" "2"
      #     Option "Coordinate Transformation Matrix" "1 0 0 0 1 0 0 0 .6"
      #   EndSection
      # '';

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
    fontDir.enable = true;
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
    # Network Manager Applet
    nm-applet.enable = true;
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

  # Network
  networking = {
    networkmanager.enable = true;
    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ 8888 ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    firewall.enable = true;
    # /etc/hosts
    extraHosts = ''
    '';
  };
}
