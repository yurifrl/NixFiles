# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./home
  ];

  environment.variables = {
    EDITOR = "vim";
    TERMINAL = "st";
    SHELL = "fish";
  };

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

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

  nixpkgs.config = {
    allowUnfree = true;

    packageOverrides = pkgs: {
      st = pkgs.callPackage ../pkgs/st {};
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    meld
    vscode
    go
    st
    git
    wget
    vim
    emacs
    kbfs
    keybase-go
    fish
    docker
    docker-compose
    tmux
    google-chrome-beta
    ranger
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;


  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # ???????
  # services.acpid.enable = true;

  # services.redshift = {
  #   enable = false;
  #   latitude = "-23.502428";
  #   longitude = "-46.626527";
  #   temperature.day = 6500;
  #   temperature.night = 2700;
  # };

  # List services that you want to enable:
  services = {

  # Enable the OpenSSH daemon.
  openssh.enable = true;


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
  keybase = {
    enable = true;
  };
  kbfs = {
    enable = true;
    mountPoint = "%h/Keybase";
  };
};

  #programs.st.enable = true;
  virtualisation.docker.enable = true;
}
