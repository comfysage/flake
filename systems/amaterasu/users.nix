{ inputs', ... }:
{
  garden.system = {
    mainUser = "isabel";
  };

  home-manager.users.isabel.garden = {
    environment = {
      desktop = "cosmic";
    };

    programs = {
      cli = {
        enable = true;
        modernShell.enable = true;
      };
      tui.enable = true;
      gui.enable = true;

      git.signingKey = "3E7C7A1B5DEDBB03";

      discord.enable = true;
      zathura.enable = true;
      wezterm.enable = true;
      ghostty.enable = true;
      chromium.enable = true;
      fish.enable = true;

      neovim.package = inputs'.izvim.packages.default;
    };
  };
}
