{ theme, lib, config, pkgs, ... }: {
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "make"
      "comment"
      "blueprint"
      "everforest"
      "sql"
      "tombi"
      "git-firefly"
      "postgres-language-server"
      "xml"
      "markdown-oxide"
      "typos"
      "gdscript"
      "java"
      "csv"
      "html"
      "kotlin"
      "terraform"
      "toml"
      "typst"
    ];

    userKeymaps = [
      {
        context = "Editor";
        bindings."f2" = "editor::Rename";
      }
      {
        context = "Editor";
        unbind."shift-f6" = "editor::Rename";
      }
      {
        context = "Editor";
        unbind."f2" = "editor::GoToDiagnostic";
      }
      { bindings."ctrl-f1" = "file_finder::Toggle"; }
      {
        context = "Workspace";
        unbind."ctrl-shift-n" = "file_finder::Toggle";
      }
      { bindings."ctrl-f2" = "text_finder::Toggle"; }
      {
        context = "Workspace";
        unbind."ctrl-t" = "project_symbols::Toggle";
      }
      {
        context = "Workspace";
        bindings."ctrl-t" = "workspace::NewTerminal";
      }
      {
        context = "Workspace";
        unbind."ctrl-~" = "workspace::NewTerminal";
      }
      { bindings."enter" = "git::ViewFile"; }
      {
        context = "Editor";
        unbind."ctrl-up" = "editor::MoveToBeginning";
      }
      {
        context = "Editor && multibuffer";
        unbind."ctrl-up" = "editor::MoveToStartOfExcerpt";
      }
      {
        context = "Editor && multibuffer";
        unbind."ctrl-down" = "editor::MoveToStartOfNextExcerpt";
      }
      {
        context = "Editor";
        unbind."ctrl-down" = "editor::MoveToEnd";
      }
      {
        bindings."ctrl-down" = [ "editor::MoveDownByLines" { lines = 5; } ];
      }
      { bindings."ctrl-up" = [ "editor::MoveUpByLines" { lines = 5; } ]; }
      { bindings."ctrl-f3" = "agent::FocusAgent"; }
    ];

    # todo find a way to disable shadows
    userSettings = {
      colorize_brackets = true;
      diagnostics.inline = {
        min_column = 0;
        update_debounce_ms = 10;
        enabled = true;
      };

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
        "panel.overlay_background" = "#${config.lib.stylix.colors.base02}";
        "border" = "#${config.lib.stylix.colors.base02}";
      };

      languages = {
        Nix = {
          language_servers = [ "nil" "!nixd" ];
          formatter = { external = { command = "nixfmt"; }; };
        };
      };

      lsp = {
        vtsls = {
          settings = {
            vtsls.experimental.maxInlayHintLength = 50;
            typescript.updateImportsOnFileMove.enabled = "always";
            javascript.updateImportsOnFileMove.enabled = "always";
          };
          enable_lsp_tasks = true;
        };
        rust-analyzer.initialization_options.rust.analyzerTargetDir = true;
        jdtls.settings = {
          jdtls_launcher = "${pkgs.jdt-language-server}/bin/jdtls";
          java_home = "${pkgs.jdk21.home}";
          check_updates = "never";
          jdk_auto_download = false;
        };
      };

      vim.toggle_relative_line_numbers = false;
      redact_private_values = false;
      preferred_line_length = 80;
      markdown_preview.max_width = 1000.0;
      git = {
        gutter_debounce = 50;
        blame.show_avatar = true;
        inline_blame = {
          min_column = 75;
          padding = 10;
          show_commit_summary = true;
          location = "inline";
        };
      };
      document_symbols = "off";
      document_folding_ranges = "off";
      semantic_tokens = "off";
      unnecessary_code_fade = 0.5;
      current_line_highlight = "all";
      rounded_selection = true;
      show_wrap_guides = true;
      indent_guides = {
        active_line_width = 4;
        line_width = 1;
        coloring = "fixed";
        background_coloring = "disabled";
      };
      autosave.after_delay.milliseconds = 1000;
      cursor_shape = "bar";
      cursor_animation.enabled = false;
      text_rendering_mode = "platform_default";
      completions.words_min_length = 2;
      diff_view_style = "split";
      prettier.allowed = true;
      format_on_save = "on";
      relative_line_numbers = "enabled";
      hover_popover_delay = 100;
      toolbar = {
        code_actions = true;
        agent_review = true;
        selections_menu = true;
        quick_actions = true;
        breadcrumbs = true;
      };
      outline_panel = {
        folder_indicator = "icon";
        button = true;
        dock = "left";
      };
      git_panel = {
        show_count_badge = false;
        tree_view = true;
        file_icons = false;
        status_style = "icon";
        dock = "left";
      };
      project_panel = {
        folder_indicator = "icon";
        hide_root = true;
        indent_guides.show = "always";
        git_status_indicator = true;
        diagnostic_badges = true;
        bold_folder_labels = false;
        git_status = true;
        file_icons = true;
        default_width = 240.0;
        entry_spacing = "standard";
        dock = "left";
      };
      minimap = {
        thumb_border = "left_open";
        display_in = "active_editor";
        show = "auto";
        current_line_highlight = "all";
      };
      collaboration_panel = {
        dock = "left";
        button = false;
      };

      edit_predictions = {
        provider = "none";
        open_ai_compatible_api.api_url = "";
      };

      agent = {
        dock = "right";
        show_turn_stats = true;
        profiles = { };
        sandbox_permissions.allow_unsandboxed = true;
        tool_permissions = {
          default = "allow";
          tools = {
            write_file.default = "allow";
            terminal.default = "allow";
          };
        };
        terminal_init_command = "";
        sidebar_side = "left";
        play_sound_when_agent_done = "never";
        single_file_review = false;
      };

      load_direnv = "shell_hook";
      buffer_font_family = "JetBrainsMono Nerd Font";
      ui_font_family = "Noto Sans";
      buffer_font_weight = 300.0;
      ui_font_weight = 300.0;
      ui_font_size = 15;
      buffer_font_size = 13;
      buffer_line_height = "comfortable";

      inlay_hints = {
        enabled = true;
        show_type_hints = true;
        show_parameter_hints = true;
        show_other_hints = true;
        show_background = false;
        edit_debounce_ms = 300;
      };

      terminal = {
        line_height = "standard";
        env = { TERM = "ghostty"; };
        toolbar.breadcrumbs = true;
        font_weight = 300.0;
        font_family = "JetBrainsMono Nerd Font";
        show_count_badge = true;
        dock = "bottom";
      };

      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      theme = lib.mkForce {
        mode = "system";
        light = theme.zed;
        dark = theme.zed;
      };

      base_keymap = "JetBrains";

      title_bar = {
        show_user_picture = false;
        show_sign_in = false;
        show_onboarding_banner = false;
      };
    };
  };
}
