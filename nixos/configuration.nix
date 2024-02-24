# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ 
  inputs,
  config, 
  lib, 
  pkgs, 
  ... 
}:  {
  imports = [
      ./hardware-configuration.nix
  ];
  
  nixpkgs = {
    overlays = [
	    # Overlays
    ];
    config = {
      allowUnfree = true;
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hp-nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Lisbon";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  programs.hyprland.enable = true;
  programs.zsh.enable = true;

  # Sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Users
  users.defaultUserShell = pkgs.zsh;
  users.users = {
    samuh = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; 
      packages = with pkgs; [
	      chromium

        curl
        wget
        neofetch
        kitty
        neofetch
        neovim
        zsh
        flameshot
        mpv
        stremio
        brightnessctl
        
        # WM
        waybar
        wofi
        hyprpaper
        
        # development
        git
        python3
        
        # Non FOOS
        spotify
        vscode
        discord
        #steam
      ];
    };
  };

  # SSH
  services.openssh = {
    enable = false;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  #fonts.packages = with pkgs; [
  #  noto-fonts
  #  noto-fonts-cjk
  #  noto-fonts-emoji
  #  liberation_ttf
  #  fira-code
  #  fira-code-symbols
  #  mplus-outline-fonts.githubRelease
  #  dina-font
  #  proggyfonts
  #  (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "NerdFontsSymbolsOnly" ]; })
  #];

  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "23.11";
}

