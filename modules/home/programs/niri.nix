{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkIf mkMerge;

  cfg = config.programs.niri;
in
{
  # vendor inputs.niri.homeModules.niri without the `self.homeModules.config` import
  options.programs.niri = {
    enable = lib.mkEnableOption "niri";
    xwayland = lib.mkEnableOption "xwayland" // {
      default = true;
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      home.packages = [
        cfg.package
      ];
      services.gnome-keyring.enable = true;
      xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
        configPackages = [ cfg.package ];
      };

      programs.niri.settings.spawn-at-startup = [
        {
          argv = [
            "${pkgs.dbus}/bin/dbus-update-activation-environment"
            "--systemd"
            "--all"
          ];
        }
      ];
    }
    (mkIf cfg.xwayland {
      home.packages = [ pkgs.xwayland ];

      programs.niri.settings.xwayland-satellite = {
        enable = true;
        path = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
      };

      systemd.user.services.xwayland-satellite = {
        Unit = {
          Description = "Xwayland satellite service";
          After = [ config.wayland.systemd.target ];
          PartOf = [ config.wayland.systemd.target ];
          BindsTo = [ config.wayland.systemd.target ];
          Requisite = [ config.wayland.systemd.target ];
        };
        Service = {
          Type = "notify";
          NotifyAccess = "all";
          ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
          StandardOutput = "journal";
        };
        Install.WantedBy = [ config.wayland.systemd.target ];
      };
    })
  ]);
}
