{ config, lib, pkgs, modulesPath, ... }:

{ 
 # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rick = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" "zh_CN.UTF-8/UTF-8" ];
  };
  i18n.inputMethod = {
      type  = "fcitx5";
      enable = true;
      fcitx5.addons = with pkgs; [
	rime-data
        fcitx5-gtk
        fcitx5-chinese-addons
        librime
      ];
      fcitx5.waylandFrontend = true;
  };
  environment.sessionVariables = {
	GTK_IM_MODULE = "fcitx";
	INPUT_METHOD = "fcitx";
	XMODIFIERS = "@im=fcitx";
	QT_IM_MODULE = "fcitx";
	SDL_IM_MODULE = "fcitx";
        QT_QPA_PLATFORM = "wayland";
        IM_MODULE_CLASSNAME = "QComposeInputContext";
	
  };
  # fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    noto-fonts-extra
    lxgw-wenkai
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  environment.sessionVariables = {
    # This variable tells Hyprland which hyprcursor theme to use
    HYPRCURSOR_THEME = "Bibata-Modern-Ice";
    HYPRCURSOR_SIZE = "24";

    # This variable sets the fallback X cursor theme for other applications
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };
}
