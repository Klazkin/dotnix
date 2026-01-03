{ theme, lib, config, ... }: {
  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" "toml" "elixir" "make" ];

    # todo find a way to disable shadows
    userSettings = {
      "experimental.theme_overrides" = {
        "background" = "#${config.lib.stylix.colors.base00}b3";
        "background.appearance" = "transparent";
        "title_bar.background" = "#${config.lib.stylix.colors.base00}b3";
        "title_bar.inactive_background" =
          "#${config.lib.stylix.colors.base00}b3";
        "tab_bar.background" = "#00000000";
        "tab.inactive_background" = "#00000000";
        "panel.background" = "#00000000";
        "status_bar.background" = "#${config.lib.stylix.colors.base00}";
        "element.selected" = "#${config.lib.stylix.colors.base01}";
        "panel.focused_border" = "#${config.lib.stylix.colors.base0D}";
      };

      languages = {
        Nix = {
          language_servers = [ "nil" "!nixd" ];
          formatter = { external = { command = "nixfmt"; }; };
        };
      };

      agent = {
        enabled = true;
        default_model = {
          provider = "zed.dev";
          model = "claude-3-5-sonnet-latest";
        };
      };

      load_direnv = "shell_hook";
      buffer_font_family = "JetBrainsMono Nerd Font";
      ui_font_family = "Noto Sans";
      buffer_font_weight = 200;

      inlay_hints = {
        enabled = true;
        show_type_hints = true;
        show_parameter_hints = true;
        show_other_hints = true;
        edit_debounce_ms = 300;
      };

      terminal = {
        line_height = "standard";
        env = { TERM = "ghostty"; };
      };

      telemetry = {
        diagnostics = true;
        metrics = false;
      };

      theme = lib.mkForce {
        mode = "system";
        light = theme.zed;
        dark = theme.zed;
      };

      base_keymap = "JetBrains";
      title_bar = { show_user_picture = false; };
    };
  };
}
