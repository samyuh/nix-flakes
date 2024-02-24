# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    overlays = [
      # You can add overlays here
    ];
    config = {
      allowUnfree = true;
    };
  };

  # TODO: Set your username
  home = {
    username = "samuh";
    homeDirectory = "/home/samuh";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [ 
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

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}
