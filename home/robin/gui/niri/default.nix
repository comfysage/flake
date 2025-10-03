{
  lib,
  pkgs,
  inputs,
  inputs',
  config,
  ...
}:
let
  cfg = config.programs.niri;
in
{
  imports = [
    ./config
  ];

  config = lib.mkIf cfg.enable {
    garden.packages = {
      inherit (pkgs) swww;
      inherit (inputs'.tgirlpkgs.packages)
        haikei
        moonblast
        hyprflare-playercontrol
        ;
    };

    home.sessionVariables = {
      MOONBLAST_EDITOR = "satty --filename";
    };

    programs.niri.settings = {
      cursor =
        let
          pointer = config.home.pointerCursor;
        in
        {
          theme = pointer.name;
          inherit (pointer) size;
        };
    };
  };
}
