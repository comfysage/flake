{
  lib,
  ...
}:
let
  inherit (lib) mkMerge imap;

  workspaces = [
    { name = "editor"; }
    null
    {
      name = "browser";
      monitor = "HDMI-A-1";
      matches = [ { app-id = "^zen-"; } ];
    }
    {
      name = "notes";
      matches = [ { app-id = "^obsidian$"; } ];
    }
    {
      name = "music";
      matches = [ { app-id = "^spotify$"; } ];
    }
    {
      name = "chat";
      matches = [ { app-id = "^discord$"; } ];
    }
  ];
in
mkMerge (
  imap (
    i: workspace:
    if (workspace != null && workspace ? "name") then
      {
        programs.niri.settings = {
          workspaces.${workspace.name} = {
            open-on-output = if workspace ? "monitor" then workspace.monitor else "eDP-1";
          };
          binds = {
            "Mod+${i}".action.focus-workspace = workspace.name;
          };
          window-rules =
            if workspace ? "matches" then
              [
                {
                  inherit (workspace) matches;
                  open-on-workspace = workspace.name;
                }
              ]
            else
              [ ];
        };
      }
    else
      { }
  ) workspaces
)
