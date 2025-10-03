{
  lib,
  self,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (self.lib) mkGraphicalService;
in
{
  config = mkIf config.garden.profiles.graphical.enable {
    systemd.user.services.swww = mkGraphicalService {
      Unit.Description = "Swww Daemon";
      Service = {
        ExecStart = "${pkgs.swww}/bin/swww-daemon";
        Restart = "always";
      };
    };
  };
}
