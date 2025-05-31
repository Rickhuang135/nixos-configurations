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

  # fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  fileSystems."/mnt/C" =
    { device = "/dev/disk/by-partuuid/09b0cb85-357d-41b8-a225-ef52aecac00d";
      fsType = "ntfs-3g"; 
      options = [ "rw" "uid=1000"];
    };
  fileSystems."/mnt/D" =
    { device = "/dev/disk/by-partuuid/876d3096-07a8-4a94-a060-fd02fb3ab346";
      fsType = "ntfs-3g"; 
      options = [ "rw" "uid=1000"];
    };
  fileSystems."/home/rick/windows_user" =
    { depends = [ "/mnt/C" ];
      device = "/mnt/C/Users/Rick/";
      fsType = "none";
      options = [ "bind" "nofail" ];
    };
  fileSystems."/home/rick/UoA" =
    { depends = [ "/mnt/C" ];
      device = "/mnt/C/Users/Rick/Documents/UoA/";
      fsType = "none";
      options = [ "bind" "nofail" ];
    };
  fileSystems."/home/rick/Music" =
    { depends = [ "/mnt/C" ];
      device = "/mnt/C/Users/Rick/Music";
      fsType = "none";
      options = [ "bind" "nofail" ];
    };
  fileSystems."/home/rick/Programs" =
    { depends = [ "/mnt/D" ];
      device = "/mnt/D/Programs";
      fsType = "none";
      options = [ "bind" "nofail" ];
    };
}
