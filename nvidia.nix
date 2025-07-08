{ config, lib, pkgs, modulesPath, ... }:

{
  # Wayland Compatibbility for NVIDIA
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = false;
    nvidiaSettings = true;
    prime = {
      offload = { 
         enable = true;
         enableOffloadCmd = true;
      };
      #sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
  boot.kernelParams = [ "i915.modeset=1" "nouveau.modeset=0" ];
  services.xserver.videoDrivers = ["modesetting" "nvidia"];
}
