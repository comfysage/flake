{
  lib,
  pkgs,
  inputs',
  config,
  ...
}:
let
  cfg = config.programs.hyprland;
in
{
  imports = [ ./config ];

  options = {
    programs.hyprland = {
      enable = lib.mkEnableOption "Hyprland window manager";
    };
  };

  config = lib.mkIf cfg.enable {
    garden.packages = {
      inherit (pkgs) swww hyprpicker;
      inherit (inputs'.tgirlpkgs.packages)
        haikei
        moonblast
        hyprflare-playercontrol
        hyprflare-wallselect
        ;
    };

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;

      systemd = {
        enable = true;
        variables = [ "--all" ];
        extraCommands = [
          "systemctl --user stop graphical-session.target"
          "systemctl --user start hyprland-session.target"
        ];
      };
    };
  };
}
