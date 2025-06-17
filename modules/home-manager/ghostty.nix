{ config, theme, ... }: {

  programs.ghostty = {
    enable = true;
    settings = {
      # font settings managed by stylix

      # use custom gtk for blur and opacity
      background-opacity = 0.0;
      background-blur-radius = 20;
      theme = theme.ghostty;
      unfocused-split-opacity = 1.0;
      window-theme = "dark";
      shell-integration = "zsh";
      gtk-titlebar = false;
      # use stylix bg color to match the rest of the system
      background = config.lib.stylix.colors.base00;
    };
  };
}
