{
  lib,
  self,
  pkgs,
  config,
  inputs,
  inputs',
  ...
}:
let
  inherit (lib) mkIf mkMerge;
  inherit (self.lib) anyHome;

  cond = anyHome config (conf: conf.programs.niri.enable);
  pkg = inputs'.niri.packages.niri-unstable;
in
{
  imports = [ inputs.niri.nixosModules.niri ];

  config = mkMerge [
    {
      programs.niri.package = lib.mkForce pkg;
    }
    (mkIf cond {
      xdg.portal = {
        wlr.enable = false;
        configPackages = [ config.programs.niri.package ];

        config.common = {
          "org.freedesktop.impl.portal.Access" = "gtk";
          "org.freedesktop.impl.portal.Notification" = "gtk";
          "org.freedesktop.impl.portal.ScreenCast" = "niri";
        };
      };
      services = {
        graphical-desktop.enable = true;
        displayManager.sessionPackages = [ config.programs.niri.package ];
      };

      garden.packages = {
        niri = config.programs.niri.package;
        inherit (pkgs) xdg-utils;
      };
    })
  ];
}
