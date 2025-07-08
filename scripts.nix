{ config, lib, pkgs, inputs, ... }:

  let
      adjustScaleScript = pkgs.writeShellScriptBin "adjust_scale" ''
        #!/bin/sh
        if /run/current-system/sw/bin/hyprctl monitors | grep -q "LG Electronics LG FULL HD" ; then
        # External monitor is connected, set laptop scale to 2.4
          /run/current-system/sw/bin/hyprctl keyword monitor "eDP-1,preferred,auto,2.4"
        else
        # No external monitor, set laptop scale to 1.67
          /run/current-system/sw/bin/hyprctl keyword monitor "eDP-1,preferred,auto,1.67"
        fi
      '';
    in {
	environment.systemPackages = with pkgs; [
	    (writeShellScriptBin "nvidia-offload" ''
	      #!/bin/sh
	      export __NV_PRIME_RENDER_OFFLOAD=1
	      export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
	      export __GLX_VENDOR_LIBRARY_NAME=nvidia
	      export __VK_LAYER_NV_optimus=NVIDIA_only
	      exec "$@"
	    '')
	    adjustScaleScript
      ];
    }

