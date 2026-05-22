{ ... }: {
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

      terminal = {
        line_height = "standard";
        env = { TERM = "ghostty"; };
      };

      telemetry = {
        diagnostics = true;
        metrics = false;
      };

      theme = {
        mode = "system";
        light = "One Light";
        dark = "Gruvbox Dark Hard";
      };

      base_keymap = "JetBrains";
    };
  };
}
