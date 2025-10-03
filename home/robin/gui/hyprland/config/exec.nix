{
  lib,
  config,
  ...
}:
let
  inherit (lib.lists) optionals;

  pointer = config.home.pointerCursor;
  inherit (config.garden.programs) defaults;
in
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "hyprctl setcursor ${pointer.name} ${toString pointer.size}"
    ]
    ++ optionals (defaults.bar == "waybar") [ "waybar" ];
  };
}
