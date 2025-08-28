{ config, lib, pkgs, modulesPath, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  # OS essentials
    ntfs3g
    tlp
    networkmanagerapplet
    tpm2-tss
    easyeffects
    pipewire
  # OS tools
    pciutils
    pmutils
    tpm2-tools
    mesa-demos
    cudatoolkit
  # version and dependency management
    git
    direnv
    nix-direnv
  # hyprland and pluggins
    hyprland
    hypridle
    hyprshot
    wayland
    xwayland
    waybar
    brightnessctl
    playerctl
    libnotify
    glibcLocales
    fcitx5-configtool
    wl-clipboard
    cliphist
  # essentail apps
    kitty
    wofi
    kdePackages.dolphin
    btop
    brave
  # Interpreters, compillers and converters
    python313
    jdk
    typst
    pandoc
    xlsx2csv
    poppler-utils
  # other GUI software
    gimp3
    mpv
    vscode
    zathura
  # 3D printing
    freecad-wayland
    bambu-studio
  ];
}
