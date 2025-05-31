{ config, lib, pkgs, modulesPath, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  # hardware programs
    easyeffects
    pipewire
    ntfs3g
    tlp
    networkmanagerapplet
  # dependency management
    direnv
    nix-direnv
  # display and windows
    hyprland
    wayland
    xwayland
    brightnessctl
  # essentail display programs
    waybar
    kitty
    wofi
    libnotify
  # CLI software  
    wl-clipboard
    cliphist
    playerctl
    git
    python313
    python313Packages.numpy
    nodejs_23
  # GUI software
    hyprshot
    dolphin
    btop
    brave
    gimp
    vscode
  # testing
   # python312Packages.numpy
  ];
}
