{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "tag bitwarden, title:( - Bitwarden)"
      "tag terminal, class:^(com.mitchellh.ghostty)$"

      "float, tag:bitwarden"
      "float, title:^(rofi)$"
      "float, title:^(pwvucontrol)$"
      "float, title:^(nm-connection-editor)$"
      "float, title:^(blueberry.py)$"
      "float, title:^(Color Picker)$"
      "float, title:^(Network)$"
      "float, title:^(com.github.Aylur.ags)$"
      "float, title:^(xdg-desktop-portal)$"
      "float, title:^(xdg-desktop-portal-gnome)$"
      "float, title:^(transmission-gtk)$"
      "size 800 600,tag:bitwarden"

      "norounding, tag:terminal"

      "content video, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"
      "move 100%-w-8 100%-w-8, title:^(Picture-in-Picture)$"
      "opacity 0.8, focus:0, title:^(Picture-in-Picture)$"
      "nofollowmouse on, title:^(Picture-in-Picture)$"

      "keepaspectratio on, content:video"
    ];

    windowrulev2 = [
      "float, title:^(Picture-in-Picture)$"
      "float, class:^(feh)$"
      "float, class:^(download)$"

      "workspace 6, title:^(.*(Disc|WebC)ord.*)$"

      # throw sharing indicators away
      "workspace special silent, title:^(Firefox — Sharing Indicator)$"
      "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"
    ];
  };
}
