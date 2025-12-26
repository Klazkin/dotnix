{ theme, lib, ... }: {
  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" "toml" "elixir" "make" ];

    userSettings = {

      lsp = { rust-analyzer = { binary = { path_lookup = true; }; }; };

      languages = {
        Nix = {
          language_servers = [ "nil" "!nixd" ];
          formatter = { external = { command = "nixfmt"; }; };
        };
      };

      assistant = {
        enabled = true;
        version = "2";
        default_model = {
          provider = "zed.dev";
          model = "claude-3-5-sonnet-latest";
        };
      };

      load_direnv = "shell_hook";
      buffer_font_family = "JetBrainsMono Nerd Font";
      ui_font_family = "Noto Sans";
      buffer_font_weight = 200;
      buffer_font_size = lib.mkForce 20;
      ui_font_size = lib.mkForce 20;

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
    };
  };
}
