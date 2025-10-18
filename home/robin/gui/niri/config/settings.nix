{
  lib,
  inputs,
  config,
  osConfig,
  ...
}:
let
  inherit (config.evergarden) variant accent;
  palette = inputs.evergarden.lib.palette.${variant};

  dev = osConfig.garden.device;
in
{
  programs.niri.settings = {
    input = {
      power-key-handling.enable = false;

      keyboard = {
        numlock = true;
        repeat-rate = 50;
        repeat-delay = 250;

        xkb = {
          layout = dev.keyboard;
          options = "caps:escape_shifted_capslock";
        };
      };

      touchpad = {
        accel-speed = 0.8;
        accel-profile = "flat";
        click-method = "clickfinger";
        tap = true;
        drag = true;
        dwt = true;
        scroll-factor = 0.2;
      };
    };

    outputs."HDMI-A-1" = {
      mode = {
        width = 1920;
        height = 1080;
        refresh = 144.0;
      };
    };

    overview = {
      zoom = 0.67;
      backdrop-color = palette.mantle;
      workspace-shadow.enable = false;
    };

    layout = {
      background-color = "transparent";
    };

    layer-rules = [
      {
        matches = [
          {
            namespace = "^swww-daemon$";
          }
        ];
        place-within-backdrop = true;
      }
    ];

    prefer-no-csd = true;

    layout = {
      empty-workspace-above-first = true;

      border = {
        enable = true;
        width = 6;
        active = {
          color = "#${palette.${accent}}";
        };
        inactive = {
          color = "#${palette.surface1}";
        };
      };

      focus-ring = {
        enable = false;
      };

      shadow = {
        enable = true;
      };
    };

    window-rules = [
      {
        draw-border-with-background = false;
        geometry-corner-radius = lib.genAttrs [ "top-left" "top-right" "bottom-left" "bottom-right" ] (
          lib.const 8.0
        );
        clip-to-geometry = true;
      }
    ];
  };
}
