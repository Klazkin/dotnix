{ config, theme, pkgs, ... }:

let
  # for some reason the flat style doesn't properly respect gtk css primary fg color
  custom_css = pkgs.writeText "ghostty_custom.css" ''
    tabbar {
      color: #${config.lib.stylix.colors.base05};
    }
  '';
in {

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
      gtk-titlebar = true;
      gtk-titlebar-style = "tabs";
      gtk-toolbar-style = "flat";
      gtk-wide-tabs = false;
      # use stylix bg color to match the rest of the system
      background = config.lib.stylix.colors.base00;
      gtk-custom-css = "${custom_css}";
    };
  };
}
