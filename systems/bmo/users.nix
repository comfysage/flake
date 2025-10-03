{
  garden.system = {
    users = [ "robin" ];
  };

  home-manager.users.robin = {
    programs = {
      niri.enable = true;

      # programs
      chromium.enable = true;
      discord.enable = true;
    };

    garden.programs.defaults = {
      shell = "zsh";
      terminal = "ghostty";
      bar = "quickshell";
      browser = "zen";
      screenLocker = null;
    };
  };
}
