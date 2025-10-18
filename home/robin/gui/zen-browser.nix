{
  lib,
  pkgs,
  config,
  inputs,
  inputs',
  ...
}:
let
  inherit (lib) mkIf;
in
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  config =
    mkIf (config.garden.profiles.graphical.enable && config.garden.programs.defaults.browser == "zen")
      {
        programs.zen-browser = {
          enable = true;
          extraPrefsFiles = [
            (builtins.fetchurl {
              url = "https://raw.githubusercontent.com/MrOtherGuy/fx-autoconfig/master/program/config.js";
              sha256 = "sha256-gNxCEmSj6gQnXhckt7VyNPiSVOlYKmwX6akRtlw6ptc=";
            })
          ];

          policies = {
            DisableAppUpdate = true;
            DisableFirefoxStudies = true;
            DisablePocket = true;
            DisableTelemetry = true;
            DontCheckDefaultBrowser = true;
            NoDefaultBookmarks = true;
            OfferToSaveLogins = false;
            Preferences =
              let
                locked = value: {
                  Value = value;
                  Status = "locked";
                };
                inherit (config.evergarden) variant accent;
                palette = inputs.evergarden.lib.palette.${variant};
              in
              builtins.mapAttrs (_: locked) {
                "browser.tabs.warnOnClose" = false;
                "media.videocontrols.picture-in-picture.video-toggle.enabled" = true;
                "browser.tabs.groups.enabled" = true;
                "zen.urlbar.behavior" = "float";
                "zen.theme.accent-color" = palette.${accent};
              };
          };
        };

        programs.zen-browser.nativeMessagingHosts = [ pkgs.firefoxpwa ];
      };
}
