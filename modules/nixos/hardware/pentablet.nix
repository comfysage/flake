{lib, config, ...}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.garden.device.pentablet;
in
{
  options.garden.device.pentablet = {
    enable = mkEnableOption "Enable pentablet support";
  };

  config = mkIf cfg.enable {
    hardware.opentabletdriver.enable = true;

    nixpkgs.config.permittedInsecurePackages = [
      "mono-5.20.1.34"
    ];
  };
}
