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
    pciutils
  # security
    tpm2-tools
    tpm2-tss
  # dependency management
    direnv
    nix-direnv
  # display and windows
    hyprland
    hypridle
    wayland
    xwayland
    brightnessctl
  # essentail display programs
    waybar
    kitty
    wofi
    libnotify
    glibcLocales
    fcitx5-configtool
  # nvidia related
    mesa-demos
    cudatoolkit
  # CLI software  
    wl-clipboard
    cliphist
    playerctl
    git
    python313
    nodejs_23
    jdk
    dos2unix
  # GUI software
    hyprshot
    kdePackages.kcharselect
    dolphin
    btop
    brave
    gimp
    vscode
  ];
}
