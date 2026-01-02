{ theme, lib, ... }: {
  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" "toml" "elixir" "make" ];

    userSettings = {
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
