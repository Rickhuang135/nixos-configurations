{ config, lib, pkgs, modulesPath, ... }:

{
  # Wayland Compatibbility for NVIDIA
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["intel" "nvidia"];
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
  boot.blacklistedKernelModules = [ "nouveau" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
    prime = {
    #  offload = false;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:3:0:0";
    };
  };
}
