# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
  homedir = builtins.getEnv "HOME";
  mySt = pkgs.callPackage ../pkgs/st {};
  kconf = pkgs.callPackage ../pkgs/kconf {};
in {
  imports = [
    ./home
  ];

  environment.variables = {
    EDITOR = "vim";
    TERMINAL = "st";
    SHELL = "fish";
    PATH = "${homedir}/.bin:$PATH";
  };

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
        unstable = import unstableTarball {
          config = config.nixpkgs.config;
        };
      };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    unstable.tmux
    unstable.fish
    #unstable.pbis-open
    networkmanagerapplet
    networkmanager_openvpn
    cabal-install
    gitAndTools.diff-so-fancy
    kconf
    pulsemixer
    meld
    vscode
    go
    mySt
    git
    wget
    vim
    emacs
    kbfs
    keybase-go
    docker
    docker-compose
    google-chrome-beta
    ranger
    xorg.xhost
    xorg.xbacklight
  ];

  # Network
  networking.networkmanager.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  #
  virtualisation.docker.enable = true;

  # List services that you want to enable:
  services = {
    # redshift = {
    #   enable = false;
    #   latitude = "-23.502428";
    #   longitude = "-46.626527";
    #   temperature.day = 6500;
    #   temperature.night = 2700;
    # };

    # ???????
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
      enable = true;
      autorun = true;
      exportConfiguration = true;
      libinput.enable = true;
      windowManager = {
        default = "i3";
        i3 = {
          enable = true;
          extraPackages = with pkgs; [
            dmenu
            i3status
            i3lock
            i3blocks
            acpi
            xclip
          ];
        };
      };
      desktopManager = {
        default = "none";
        xterm.enable = false;
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yuri = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      # anonymousPro
      # corefonts
      # dejavu_fonts
      # font-droid
      # freefont_ttf
      # google-fonts
      # inconsolata
      # liberation_ttf
      powerline-fonts
      source-code-pro
      # terminus_font
      # ttf_bitstream_vera
      # ubuntu_font_family
    ];
  };
}
