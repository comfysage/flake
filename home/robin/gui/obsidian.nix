{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
in
{
  programs.obsidian =
    mkIf (config.garden.profiles.graphical.enable && config.garden.profiles.workstation.enable)
      {
        enable = true;
      };
}
