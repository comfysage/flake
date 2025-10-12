{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
in
{
  programs.intelli-shell = mkIf config.garden.profiles.workstation.enable {
    enable = true;

    settings.theme = {
      primary = "default";
      secondary = "dim";
      accent = "cyan";
      comment = "italic green";
      error = "dark red";
      highlight = "darkgrey";
      highlight_symbol = " ";
      highlight_primary = "default";
      highlight_secondary = "default";
      highlight_accent = "green";
      highlight_comment = "italic 8";
    };
    shellHotkeys = {
      search_hotkey = "^@";
      bookmark_hotkey = "^b";
      variable_hotkey = "^z";
      fix_hotkey = "^x";
      skip_esc_bind = "0";
    };
  };
}
