{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (config.garden.programs) defaults;

  evswitch = pkgs.writeShellApplication {
    name = "ev-switch";
    runtimeInputs = [
      pkgs.just
      pkgs.lutgen
      pkgs.rhash
    ];
    text = ''
      exec ~/wallpapers/ev-switch.sh
    '';
  };
in
{
  programs.niri.settings = {
    binds = with config.lib.niri.actions; {
      "Mod+C".action.spawn = "neovide";
      "Mod+O".action.spawn = "obsidian";

      "Mod+Return".action.spawn = defaults.terminal;
      "Mod+L".action = spawn [
        "systemctl"
        "suspend"
      ];

      "Alt+Space".action.spawn = [
        "qs"
        "ipc"
        "call"
        "drawers"
        "toggle"
        "launcher"
      ];
      "Mod+Escape".action.spawn = [
        "qs"
        "ipc"
        "call"
        "drawers"
        "toggle"
        "session"
      ];

      "Mod+Shift+W".action = spawn-sh "haikei r $(dirname $(haikei current))";
      "Mod+Ctrl+W".action.spawn = "${lib.getExe evswitch}";

      "Mod+Shift+C".action = spawn-sh "niri msg pick-color | grep -o '#.*' | wl-copy";

      "Mod+Shift+Slash".action = show-hotkey-overlay;

      "Mod+Q".action = close-window;
      "Mod+F".action = fullscreen-window;
      "Mod+Z".action = maximize-column;
      "Mod+Tab".action = toggle-overview;

      "Print".action = spawn [
        "moonblast"
        "copysave"
        "output"
      ];
      "Mod+Shift+S".action = spawn [
        "moonblast"
        "-f"
        "copysave"
        "area"
      ];
      "Alt+Print".action = spawn [
        "moonblast"
        "copysave"
        "active"
      ];

      "Mod+Left".action = focus-column-or-monitor-left;
      "Mod+Right".action = focus-column-or-monitor-right;
      "Mod+Up".action = focus-window-or-monitor-up;
      "Mod+Down".action = focus-window-or-monitor-down;

      "Mod+Shift+Left".action = move-column-left-or-to-monitor-left;
      "Mod+Shift+Right".action = move-column-right-or-to-monitor-right;
      "Mod+Shift+Up".action = move-window-up;
      "Mod+Shift+Down".action = move-window-down;

      "Mod+Ctrl+Left".action = focus-monitor-left;
      "Mod+Ctrl+Right".action = focus-monitor-right;
      "Mod+Ctrl+Up".action = focus-monitor-up;
      "Mod+Ctrl+Down".action = focus-monitor-down;

      "Mod+Ctrl+Shift+Left".action = move-window-to-monitor-left;
      "Mod+Ctrl+Shift+Right".action = move-window-to-monitor-right;
      "Mod+Ctrl+Shift+Up".action = move-window-to-monitor-up;
      "Mod+Ctrl+Shift+Down".action = move-window-to-monitor-down;

      "Mod+I".action = focus-workspace-up;
      "Mod+U".action = focus-workspace-down;

      "Mod+Ctrl+I".action = move-workspace-up;
      "Mod+Ctrl+U".action = move-workspace-down;

      "Mod+Shift+I".action = move-column-to-workspace-up;
      "Mod+Shift+U".action = move-column-to-workspace-down;

      "Mod+Comma".action = consume-window-into-column;
      "Mod+Period".action = expel-window-from-column;

      "Mod+Space".action = toggle-window-floating;
      "Mod+V".action = switch-focus-between-floating-and-tiling;

      # global mute
      "XF86AudioMute".action.spawn = [
        "wpctl"
        "set-mute"
        "@DEFAULT_AUDIO_SINK@"
        "toggle"
      ];
      "XF86AudioMicMute".action.spawn = [
        "wpctl"
        "set-mute"
        "@DEFAULT_AUDIO_SOURCE@"
        "toggle"
      ];

      # playerctl
      "XF86AudioPlay".action.spawn = [
        "playercontrol"
        "toggle"
      ];
      "XF86AudioNext".action.spawn = [
        "playercontrol"
        "next"
      ];
      "XF86AudioPrev".action.spawn = [
        "playercontrol"
        "prev"
      ];

      # volume adjust
      "XF86AudioRaiseVolume".action.spawn = [
        "wpctl"
        "set-volume"
        "@DEFAULT_AUDIO_SINK@"
        "5%+"
      ];
      "XF86AudioLowerVolume".action.spawn = [
        "wpctl"
        "set-volume"
        "@DEFAULT_AUDIO_SINK@"
        "5%-"
      ];

      # brightness adjust
      "XF86MonBrightnessUp".action.spawn = [
        "brightnessctl"
        "set"
        "5%+"
        "-q"
      ];
      "XF86MonBrightnessDown".action.spawn = [
        "brightnessctl"
        "set"
        "5%-"
        "-q"
      ];
    };
  };
}
