{ config, lib, pkgs, inputs, ... }:

  let
      adjustScaleScript = pkgs.writeShellScriptBin "adjust_scale" ''
        #!/bin/sh
        if /run/current-system/sw/bin/hyprctl monitors | grep -q "1920x1080@" ; then
        # External monitor is connected, set laptop scale to 2.4
          /run/current-system/sw/bin/hyprctl keyword monitor "eDP-1,preferred,auto,2.4"
        else
        # No external monitor, set laptop scale to 1.67
          /run/current-system/sw/bin/hyprctl keyword monitor "eDP-1,preferred,auto,1.67"
        fi
      '';
      nvidiaOffLoad = pkgs.writeShellScriptBin "nvidia-offload" ''
	    #!/bin/sh
	    export __NV_PRIME_RENDER_OFFLOAD=1
	    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
	    export __GLX_VENDOR_LIBRARY_NAME=nvidia
	    export __VK_LAYER_NV_optimus=NVIDIA_only
	    exec "$@"
      '';        
      typstToUtf8 = pkgs.writeShellScriptBin "trans" ''
        #!/run/current-system/sw/bin/bash
        #!/usr/bin/env bash

        # typst2utf8.sh
        # Convert a Typst math expression into its UTF-8 character(s).

        # Exit if no argument provided
        if [ $# -eq 0 ]; then
          echo "Usage: $0 '<typst-expression>'"
          exit 1
        fi

        expr="\$${1}\$"
        tmpdir=$(mktemp -d)
        typfile="$tmpdir/tmp.typ"
        pdffile="$tmpdir/tmp.pdf"
        txtfile="$tmpdir/tmp.txt"

        # Write Typst file
        cat > "$typfile" <<EOF
        #set page(width: auto, height: auto)
        $expr
        EOF

        # Compile to PDF
        typst compile "$typfile" "$pdffile" >/dev/null 2>&1
        if [ $? -ne 0 ]; then
          echo "Typst compilation failed"
          rm -rf "$tmpdir"
          exit 1
        fi

        # Extract text
        pdftotext -nopgbrk -layout "$pdffile" "$txtfile"
        if [ $? -ne 0 ]; then
          echo "pdftotext failed"
          rm -rf "$tmpdir"
          exit 1
        fi

        # Print extracted text (trim whitespace)
        output=$(tr -d '\n\r' < "$txtfile" | xargs)
        echo "$output"

        # Copy to clipboard (Wayland or X11)
        if command -v wl-copy >/dev/null 2>&1; then
          printf "%s" "$output" | wl-copy
        elif command -v xclip >/dev/null 2>&1; then
          printf "%s" "$output" | xclip -selection clipboard
        elif command -v xsel >/dev/null 2>&1; then
          printf "%s" "$output" | xsel --clipboard --input
        else
          echo "⚠️  No clipboard utility (wl-copy/xclip/xsel) found. Install one to enable clipboard copy."
        fi

        # Cleanup
        rm -rf "$tmpdir"
      '';
    in {
	environment.systemPackages = with pkgs; [
	    nvidiaOffLoad
	    adjustScaleScript
	    typstToUtf8
      ];
    }

