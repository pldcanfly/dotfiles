# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernel.sysctl = {
      "vm.max_map_count" = 16777216;
      "fs.file-max" = 524288;
    };


  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  programs.dconf.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;
  services.flatpak.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # Sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_AT.UTF-8";
    LC_IDENTIFICATION = "de_AT.UTF-8";
    LC_MEASUREMENT = "de_AT.UTF-8";
    LC_MONETARY = "de_AT.UTF-8";
    LC_NAME = "de_AT.UTF-8";
    LC_NUMERIC = "de_AT.UTF-8";
    LC_PAPER = "de_AT.UTF-8";
    LC_TELEPHONE = "de_AT.UTF-8";
    LC_TIME = "de_AT.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "at";
    xkbVariant = "nodeadkeys";
  };

# nixgaming caching
  nix.settings = {
    substituters = ["https://nix-gaming.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pldcanfly = {
    isNormalUser = true;
    description = "Thomas";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      theme = "daveverwer";
    };
  };

  fonts.packages = with pkgs; [
  	(nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
         noto-fonts
  	  noto-fonts-cjk
  	  noto-fonts-emoji
  	  liberation_ttf
  	  fira-code
  	  fira-code-symbols
  	  mplus-outline-fonts.githubRelease
  	  dina-font
	  proggyfonts 
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.xserver.displayManager.sddm.enable = true;
  services.xserver.enable = true;
  programs.hyprland = {
     enable = true;
     xwayland.enable = true;
  };
  programs.waybar.enable = true;
  environment.sessionVariables = {
  NIXOS_OZONE_WL = "1";
  QT_QPA_PLATFORMTHEME = "qt6ct";
  XDG_SCREENSHOTS_DIR = "~/Pictures/Screenshots";
  };

  # programs.thunar.enable = true;
  services.gvfs.enable = true;

  # system.activationScripts.binbash = {
  #   deps = [ "binsh" ];
  #   text = ''
  #        ln -s /bin/sh /bin/bash
  #   '';
  # };


  programs.steam.enable = true;
  programs.gamemode.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget

# nixpkgs.overlays = [
#   templ.overlays.default
# ];
#
  programs.corectrl = {
    enable = true;
    # gpuOverclock = {
    #   enable = true;
    #   ppfeaturemask = "0xffffffff";
    # };
    };
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    firefox
    kitty
    wofi
    webcord
    git 
    pavucontrol
    helvum
    neovim
    lxqt.lxqt-policykit
    nwg-look
    qt6ct
    ark
    adwaita-qt
    adwaita-qt6
    go
    air
    templ
    gh
    gnumake
    gcc
    nodePackages_latest.nodejs
    nodePackages_latest.pnpm
    playerctl
    dunst
    libnotify
    lutris
    protonup-qt
    lm_sensors
    xivlauncher
    cinnamon.nemo-with-extensions
    swww
    waypaper
    wl-clip-persist
    wl-clipboard
    cliphist
    slurp
    grimblast
    nwg-bar
    swayosd
    clapper
    quodlibet-full
    gnome.eog
    spotify
    onlyoffice-bin
    oversteer 
    neofetch
    tailwindcss
    php82Packages.composer
    php
    phpactor
    gopls
    typescript
    ripgrep
    wget
    curl
    bash
    r2modman
    wine-staging
    winetricks
    inputs.nix-citizen.packages."x86_64-linux".star-citizen
    mate.atril
    brave
  ];

  services.gnome.gnome-keyring.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
