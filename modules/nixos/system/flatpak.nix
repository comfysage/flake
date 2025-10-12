{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkIf;
in
{
  config = mkIf config.garden.profiles.graphical.enable {
    services.flatpak.enable = true;

    garden.packages = {
      inherit (pkgs) flatpak;
    };

    environment.sessionVariables.XDG_DATA_DIRS = [ "/var/lib/flatpak/exports/share" ];
  };
}
