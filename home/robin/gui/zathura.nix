{ lib, config, ... }:
let
  inherit (lib) mkIf;
in
{
  config = mkIf config.garden.profiles.graphical.enable {
    programs.zathura = {
      enable = true;

      options = {
        adjust-open = "width";
        guioptions = "";
      };
      mappings = { };
    };

    garden.xdg.associations = {
      "application/pdf" = [ "zathura.desktop" ];
    };
  };
}
