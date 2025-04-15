{ lib, config, ... }:
let
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.options) mkEnableOption;
in
{
  options.garden.system.perlless = mkEnableOption "Ban perl from being installed";

  config = mkMerge [
    {
      # this can break things, perticualarly if you use containers
      # personally I don't so it should be fine to disable this
      boot.enableContainers = false;

      # Declertive user managment
      services.userborn.enable = true;

      # We enable systemd in the initrd so we can use it to mount the root
      # filesystem this will remove perl form the activation
      boot.initrd.systemd.enable = true;
    }

    (mkIf config.garden.system.perlless {
      # since we enable a hover fs we also need to allow for that filesystem in the supported filesystems
      boot = {
        supportedFilesystems = [ "erofs" ];
        initrd.supportedFilesystems = [ "erofs" ];
      };

      system = {
        etc = {
          overlay = {
            # Mount /etc as an overlayfs instead of generating it via a perl script.
            # WARNING: do not enable this if your not confident in your ability to fix it
            # it is a royal pain and is not worth half the effor it takes to fix it
            enable = true;

            mutable = true;
          };

          # create our NIXOS file so we don't error if we don't have perl installed
          environment.etc."NIXOS".text = "";
        };

        # we can use this to warn us if we have perl installed
        forbiddenDependenciesRegexes = [ "perl" ];
      };
    })
  ];
}
