# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./i3
    ./home
  ];

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

  nixpkgs.config = {
    allowUnfree = true;
  };

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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    wget
    #vim
    xst
    #emacs
    kbfs
    keybase-go
    #fish
    docker
    docker-compose
    #tmux
    google-chrome-beta
    ranger
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yuri = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  # ???????
  # services.acpid.enable = true;

  services.redshift = {
    enable = false;
    latitude = "-23.502428";
    longitude = "-46.626527";
    temperature.day = 6500;
    temperature.night = 2700;
  };

  #programs.st.enable = true;
  virtualisation.docker.enable = true;

  # Enable keybase
  services.keybase.enable = true;
  services.kbfs.enable = true;
}
