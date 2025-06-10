{ config, pkgs, lib, inputs, ... }:

with lib.hm.gvariant;

{
  imports = [
    # For home-manager
    inputs.spicetify-nix.homeManagerModules.default
    # inputs.zen-browser.
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "matpac";
  home.homeDirectory = "/home/matpac";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  fonts.fontconfig.enable = true;

  programs.firefox = { enable = true; };

  programs.wofi = { enable = true; };

  services.glance = {
    enable = true;

    settings = {
      pages = [{
        columns = [{
          size = "full";
          widgets = [
            { type = "calendar"; }
            {
              location = "Tallinn, Estonia";
              type = "weather";
            }
          ];
        }];
        name = "Home";
      }];
      server = { port = 5678; };
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  programs.git = {
    enable = true;
    userName = "matpac";
    userEmail = "matvei.matpac@gmail.com";
  };

  home.packages = with pkgs;
    [
      montserrat # font
      fastfetch
      lazygit # tui git client
      modrinth-app # minecraft client
      gnome-tweaks
      dconf-editor
      gnome-settings-daemon
      # everforest-gtk-theme
      #	gruvbox-gtk-theme
      # adwsteamgtk
      # jetbrains.webstorm
      # jetbrains.rust-rover
      discord
      pinta # paint
      # steam, enabled in configuration.nix
      # Development deps
      godot_4
      # rustc
      # rustup
      # cargo-outdated
      # pkg-config
      # gcc
      # openssl
      # openssl.dev
      # clang
      # llvmPackages.bintools
      # lutris
      # wine
      # wine64
      # winetricks
      bottles # sandboxed wine environments
      nixd # nix language server
      nil # also a nix lang server
      nixfmt # nix formatter
      via # keybaord configurator (for supported models)
      # gruvbox-dark-icons-gtk
      # gruvbox-plus-icons
      # spot
      # libreoffice
      inputs.zen-browser.packages."${system}".default

    ] ++ (with pkgs.gnomeExtensions; [
      appindicator
      blur-my-shell
      accent-directories
      dash-to-panel
      weather-or-not
      media-controls
      quick-settings-audio-panel
    ]);

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions;
      [
        teabyii.ayu
        eamodio.gitlens
        usernamehw.errorlens
        rust-lang.rust-analyzer
        mkhl.direnv
        esbenp.prettier-vscode
        ms-azuretools.vscode-docker
        sainnhe.gruvbox-material
        jnoortheen.nix-ide
        aaron-bond.better-comments
        tamasfe.even-better-toml
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "godot-tools";
          publisher = "geequlim";
          version = "2.5.1";
          sha256 = "sha256-kAzRSNZw1zaECblJv7NzXnE2JXSy9hzdT2cGX+uwleY=";
        }
        {
          name = "godot-rust-vscode";
          publisher = "dsobotta";
          version = "0.4.1";
          sha256 = "sha256-fg8dehS6DKe1FuUCkta4P4f7uvkq+lfeCjcnf02m3nE=";
        }
        # {
        #   name = "glassit";
        #   publisher = "s-nlf-fh";
        #   version = "0.2.6";
        #   sha256 = "sha256-LcAomgK91hnJWqAW4I0FAgTOwr8Kwv7ZhvGCgkokKuY=";
        # }
        # todo add rust snippets extensions
      ];

    userSettings = {
      # This property will be used to generate settings.json:
      # https://code.visualstudio.com/docs/getstarted/settings#_settingsjson
      "editor.formatOnSave" = true;
      "workbench.colorTheme" =
        lib.mkForce "Gruvbox Material Dark"; # overwrites stylix theme
      # "workbench.colorTheme" = lib.mkForce "Ayu Mirage Bordered";
      "editor.cursorSmoothCaretAnimation" = "on";
      "workbench.iconTheme" = "ayu";
      "window.titleBarStyle" = "custom";
      "editor.fontLigatures" = true;
      "godotTools.editorPath.godot4" =
        "/etc/profiles/per-user/matpac/bin/godot4";
      "editor.smoothScrolling" = true;
      # "glassit.alpha" = 176;
    };
  };

  programs.bat = { enable = true; };

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

  programs.spicetify =
    let spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in {
      enable = true;

      enabledExtensions = with spicePkgs.extensions;
        [
          # adblock
          # hidePodcasts
          shuffle # shuffle+ (special characters are sanitized out of extension names)
        ];

      enabledCustomApps = with spicePkgs.apps; [ newReleases ncsVisualizer ];

      # theme = spicePkgs.themes.catppuccin; # managed by stylix
    };

  # symbolic links for custom gtk css
  # xdg.configFile = {
  #   "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
  #   "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
  #   "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  # };
  #
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.thefuck.enable = true; # does it work?
  programs.ghostty = {
    enable = true;
    settings = {
      # font-size = 14;
      # font-family = "JetBrainsMonoNL Nerd Font";
      background-opacity = 0.0; # 0.7 opacity is set with custom gtk css
      background-blur-radius = 20;
      theme = "GruvboxDarkHard";
      # theme = "Ayu Mirage";
      # window-decoration = none;

      # The default is a bit intense for my liking
      # but it looks good with some themes
      unfocused-split-opacity = 1.0;

      # Some macOS settings
      window-theme = "dark";
      shell-integration = "zsh";
      gtk-titlebar = false;

      background = config.lib.stylix.colors.base00;
      # # Disables ligatures
      # font-feature = ["-liga" "-dlig" "-calt"];
    };
  };
  # Zsh
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    autocd = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$HOME/.nix-profile/lib/pkgconfig
    '';

    shellAliases = {
      l = "ls -l";
      ll = "ls -larh";
      py = "python";
      rr = "yazi";
      mm = "micro";
      rm = "rm -I";
      summ = "sudo micro";
      gg = "lazygit";
      zz = "zeditor";
      sfy = "spotify_player";
      update = "(cd ~/dotnix && py update.py)";
      update-nogit = "sudo nixos-rebuild switch --flake ~/dotnix";
    };
  };

  programs.spotify-player = { enable = true; }; # tui spotify client

  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = [ "git" "thefuck" ];
    # theme = "agnoster"; theme is configured via oh-my-posh
  };

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    # useTheme = "aliens";
    settings = {
      version = 3;
      final_space = true;
      shell_integration = true;
      upgrade = false;

      "$schema" =
        "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";

      console_title_template = "{{ .Folder }}";

      transient_prompt = {
        background = "transparent";
        foreground = "gray";
        template = ''{{ now | date "15:04:05" }} \ue285 '';
      };

      blocks = [
        {
          type = "prompt";
          alignment = "left";
          trailing_diamond = "\\ue0b0";
          segments = [
            {
              foreground = "black";
              background = "lightGreen";
              leading_diamond = "\\ue0b6";
              trailing_diamond = "\\ue0b0";
              background_templates =
                [ ''{{ if eq .Type "impure" }}lightCyan{{ end }}'' ];
              style = "diamond";
              type = "nix-shell";
              template = ''
                \uF313 {{ if eq .Type "impure" }}devshell{{else}}{{ .UserName }}{{ end }} '';
            }
            {
              type = "path";
              style = "diamond";
              # powerline_symbol = "\\ue0b0";
              leading_diamond = "\\ue0d7";
              foreground = "black";
              background = "white";
              properties = { style = "mixed"; };
              template = ''{{ if ne .Path "~" }} {{ .Path }} {{ end }}'';
              # exclude_folders = [ "/home/matpac" ];
            }
            {
              type = "rust";
              style = "powerline";
              powerline_symbol = "\\ue0b0";
              foreground = "default";
              background = "red";
              display_mode = "context";
              template = " \\ue68b {{ .Full }} ";
            }
            {
              type = "git";
              style = "powerline";
              powerline_symbol = "\\ue0b0";
              foreground = "default";
              background = "blue";
              background_templates = [
                "{{ if or (.Working.Changed) (.Staging.Changed) }}yellow{{ end }}"
                "{{ if and (gt .Ahead 0) (gt .Behind 0) }}red{{ end }}"
              ];
              template =
                " {{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }}  {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }}  {{ .Staging.String }}{{ end }}{{ if gt .StashCount 0 }}  {{ .StashCount }}{{ end }} ";
              properties = {
                fetch_status = true;
                fetch_upstream_icon = true;
                untracked_modes = {
                  "/Users/user/Projects/oh-my-posh/" = "no";
                };
                source = "cli";
              };
            }
          ];
        }
        {
          type = "rprompt";
          alignment = "right";
          segments = [{
            background = "red";
            foreground = "default";
            trailing_diamond = "\\ue0b4";
            leading_diamond = "\\ue0b6";
            properties = { always_enabled = false; };
            style = "diamond";
            template = "{{ if gt .Code 0 }}\\uf00d {{ reason .Code }}{{ end }}";
            type = "status";
          }];
        }
      ];

    };
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        disabled-extensions = [ ];
        enabled-extensions = [
          "weatherornot@somepaulo.github.io" # X
          "appindicatorsupport@rgcjonas.gmail.com" # X
          "blur-my-shell@aunetx"
          "accent-directories@taiwbi.com" # X
          "system-monitor@gnome-shell-extensions.gcampax.github.com" # X
          "dash-to-panel@jderose9.github.com"
          "mediacontrols@cliffniff.github.com" # X
          "quick-settings-audio-panel@rayzeq.github.io" # X
        ];

        favorite-apps = [ ];
      };

      "org/gnome/shell/extensions/weatherornot" = { position = "right"; };

      "org/gnome/shell/extensions/quick-settings-audio-panel" = {
        create-balance-slider = false;
        create-mixer-sliders = true;
        create-sink-mixer = false;
        ignore-css = false;
        media-control = "none";
        merge-panel = true;
        move-master-volume = false;
        panel-position = "top";
        remove-output-slider = false;
        separate-indicator = false;
        show-current-device = true;
      };

      "org/gnome/shell/extensions/mediacontrols" = {
        colored-player-icon = false;
        extension-index = mkUint32 0;
        extension-position = "Center";
        fixed-label-width = false;
        label-width = mkUint32 200;
        labels-order = [ "TITLE" "-" "ARTIST" ];
        scroll-labels = true;
        show-control-icons = false;
        show-control-icons-next = false;
        show-control-icons-play = false;
        show-control-icons-previous = false;
        show-control-icons-seek-backward = false;
        show-control-icons-seek-forward = false;
        show-label = true;
        show-player-icon = true;
      };

      "org/gnome/shell/extensions/appindicator" = {
        icon-brightness = 0.0;
        icon-contrast = 0.0;
        icon-opacity = 255;
        icon-saturation = 0.0;
        icon-size = 24;
        legacy-tray-enabled = true;
        tray-pos = "center";
      };

      "org/gnome/shell/extensions/blur-my-shell" = {
        hacks-level = 1;
        pipelines =
          "{'pipeline_default': {'name': <'Default'>, 'effects': <[<{'type': <'native_static_gaussian_blur'>, 'id': <'effect_04658137160128'>, 'params': <{'unscaled_radius': <20>, 'brightness': <0.69999999999999996>}>}>]>}, 'pipeline_98317024624478': {'name': <'FullBright'>, 'effects': <[<{'type': <'native_static_gaussian_blur'>, 'id': <'effect_04908479552873'>, 'params': <{'unscaled_radius': <20>, 'brightness': <1>}>}>]>}}";
        settings-version = 2;
      };

      "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
        brightness = 0.6;
        sigma = 30;
      };

      "org/gnome/shell/extensions/blur-my-shell/applications" = {
        blur = true;
        blur-on-overview = false;
        brightness = 1.0;
        dynamic-opacity = false;
        enable-all = false;
        opacity = 255;
        sigma = 20;
        whitelist = [
          "com.mitchellh.ghostty"
          "org.gnome.Extensions"
          "org.gnome.Settings"
          "org.gnome.Shell.Extensions"
          "org.gnome.Weather"
          "com.usebottles.bottles"
          "org.gnome.Extensions"
          "org.gnome.tweaks"
          "dev.alextren.Spot"
          "org.gnome.baobab"
          "org.gnome.Nautilus"
          ".guake-wrapped"
          "Code"
          "zen-beta"
        ];
      };
      "org/gnome/shell/extensions/blur-my-shell/coverflow-alt-tab".pipeline =
        "pipeline_default";
      "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
        blur = false;
        brightness = 1.0;
        override-background = true;
        pipeline = "pipeline_default";
        sigma = 5;
        static-blur = false;
        style-dash-to-dock = 2;
        unblur-in-overview = true;
      };
      "org/gnome/shell/extensions/blur-my-shell/dash-to-panel".blur-original-panel =
        true;
      "org/gnome/shell/extensions/blur-my-shell/hidetopbar".compatibility =
        true;
      "org/gnome/shell/extensions/blur-my-shell/lockscreen".pipeline =
        "pipeline_default";
      "org/gnome/shell/extensions/blur-my-shell/overview" = {
        blur = true;
        pipeline = "pipeline_default";
      };
      "org/gnome/shell/extensions/blur-my-shell/panel" = {
        blur = true;
        brightness = 1.0;
        force-light-text = false;
        override-background = true;
        override-background-dynamically = false;
        pipeline = "pipeline_default";
        sigma = 20;
        static-blur = false;
        style-panel = 0;
        unblur-in-overview = true;
      };

      "org/gnome/shell/extensions/blur-my-shell/screenshot".pipeline =
        "pipeline_default";

      "org/gnome/shell/extensions/blur-my-shell/window-list" = {
        brightness = 0.6;
        sigma = 30;
      };

      "org/gnome/shell/extensions/dash-to-panel" = {
        animate-appicon-hover = true;
        animate-appicon-hover-animation-convexity = builtins.toJSON {
          RIPPLE = 2.0;
          PLANK = 0.0;
          SIMPLE = 0.0;
        };
        animate-appicon-hover-animation-duration = builtins.toJSON {
          SIMPLE = mkUint32 81;
          RIPPLE = 130;
          PLANK = 100;
        };
        animate-appicon-hover-animation-extent = builtins.toJSON {
          RIPPLE = 4;
          PLANK = 1;
          SIMPLE = 1;
        };
        animate-appicon-hover-animation-rotation = builtins.toJSON {
          SIMPLE = 0;
          RIPPLE = 10;
          PLANK = 0;
        };
        animate-appicon-hover-animation-travel = builtins.toJSON {
          SIMPLE = 0.2;
          RIPPLE = 0.4;
          PLANK = 0.0;
        };
        animate-appicon-hover-animation-type = "SIMPLE";
        animate-appicon-hover-animation-zoom = builtins.toJSON {
          SIMPLE = 1.3;
          RIPPLE = 1.25;
          PLANK = 2.0;
        };
        appicon-margin = 6;
        appicon-padding = 5;
        appicon-style = "NORMAL";
        available-monitors = [ 0 ];
        desktop-line-use-custom-color = false;
        dot-color-dominant = true;
        dot-color-override = false;
        dot-color-unfocused-different = false;
        dot-position = "TOP";
        dot-size = 4;
        dot-style-focused = "METRO";
        dot-style-unfocused = "METRO";
        focus-highlight-dominant = true;
        focus-highlight-opacity = 30;
        group-apps = true;
        group-apps-label-font-color = "#d5c4a1";
        group-apps-label-font-color-minimized = "#d5c4a1";
        group-apps-label-font-size = 14;
        group-apps-label-font-weight = "inherit";
        group-apps-label-max-width = 130;
        group-apps-underline-unfocused = true;
        group-apps-use-launchers = false;
        hide-overview-on-startup = true;
        hot-keys = false;
        hotkeys-overlay-combo = "TEMPORARILY";
        intellihide = false;
        intellihide-behaviour = "MAXIMIZED_WINDOWS";
        intellihide-hide-from-windows = true;
        isolate-monitors = false;
        isolate-workspaces = false;
        leftbox-padding = -1;
        leftbox-size = 0;
        overview-click-to-exit = false;
        panel-anchors = ''
          {"0":"START"}
        '';
        panel-element-positions = ''
          {"0":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":false,"position":"stackedBR"}]}
        '';
        panel-lengths = ''
          {"0":100}
        '';
        panel-positions = ''
          {"0":"BOTTOM"}
        '';
        panel-sizes = ''
          {"0":40}
        '';
        primary-monitor = 0;
        progress-show-count = true;
        scroll-panel-delay = 200;
        show-favorites = false;
        show-favorites-all-monitors = true;
        show-running-apps = true;
        show-showdesktop-hover = false;
        show-tooltip = true;
        show-window-previews = true;
        showdesktop-button-width = 13;
        status-icon-padding = 4;
        stockgs-force-hotcorner = true;
        stockgs-keep-dash = false;
        stockgs-keep-top-panel = false;
        stockgs-panelbtn-click-only = false;
        trans-dynamic-anim-target = 1.0;
        trans-dynamic-anim-time = 0;
        trans-gradient-bottom-opacity = 0.35000000000000003;
        trans-gradient-top-color = "#cdab8f";
        trans-gradient-top-opacity = 0.0;
        trans-use-custom-bg = true;
        trans-panel-opacity = 0.7;
        trans-bg-color = "#" + config.lib.stylix.colors.base00;
        trans-use-custom-gradient = false;
        trans-use-custom-opacity = true;
        trans-use-dynamic-opacity = false;
        tray-padding = 4;
        tray-size = 0;
        window-preview-title-position = "TOP";
      };

      # lib.mkForce "${config.stylix.base16Scheme.base0E}";

      "org/gnome/desktop/interface" = {
        # color-scheme = "prefer-dark"; # handeled by stylx
        cursor-size = 32;
        show-battery-percentage = true;
      };

      "org/gnome/desktop/wm/preferences" = { workspace-names = [ "Main" ]; };

      # handled by stylix
      # "org/gnome/desktop/background" = {
      #       picture-uri = "file:///home/matpac/.local/share/backgrounds/2025-01-23-21-05-42-wallpaper.jpg";
      #       picture-uri-dark = "file:///home/matpac/.local/share/backgrounds/2025-01-23-21-05-42-wallpaper.jpg";
      # };

      "org/gnome/desktop/screensaver" = {
        picture-uri =
          "file:///home/matpac/.local/share/backgrounds/2025-01-23-21-05-42-wallpaper.jpg";
        primary-color = "#3465a4";
        show-cpu = false;
        show-download = true;
        show-memory = false;
        show-swap = false;
        show-upload = false;
        secondary-color = "#000000";
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        # next = [ "<Shift><Control>n" ];
        # previous = [ "<Shift><Control>p" ];
        # play = [ "<Shift><Control>space" ];
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
        {
          name = "ghostty";
          command = "ghostty";
          binding = "<Super>t";
        };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" =
        {
          name = "wofi";
          command = "wofi -show run";
          binding = "<Super>r";
        };

      "org/gnome/shell/extensions/system-monitor" = {
        show-cpu = false;
        show-download = true;
        show-memory = false;
        show-swap = false;
        show-upload = false;
      };

      # "org/gnome/shell/extensions/user-theme" = {
      #   name = "gruvbox";
      # };

    };
  };

  gtk = {
    enable = true;

    # theme = {
    # 	name = "Tokyonight-Dark";
    # 	package = pkgs.tokyonight-gtk-theme;
    # };

    # iconTheme = {
    #	name = "Tokyonight-Dark";
    #	package = pkgs.tokyo-night-gtk;
    # };

    # iconTheme = {
    #   name = "GruvboxPlus";
    #   package = gruvboxPlus;
    # };

    # theme = {
    #   name = "gruvbox";
    #   package = pkgs.gruvbox-gtk-theme;
    # };

    # theme = {
    #	name = "adw-gtk3";
    #	package = pkgs.adw-gtk3;
    # };

    # cursorTheme = {
    #   name = "Polarnight-Cursors";
    #   package = pkgs.polarnight-cursors;
    # };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  home.activation.postConfigHook = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    /run/current-system/sw/bin/python3 /etc/nixos/json_fix.py
  '';

  home.activation.removeOhMyPoshConfig =
    lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
      rm -f ~/.config/oh-my-posh/config.json
    '';

  stylix.targets.gtk.extraCss = ''
    @define-color window_bg_color #${config.lib.stylix.colors.base00}b3;

    window {
       background-color: #${config.lib.stylix.colors.base00}b3;
    }
  '';

  # xdg.configFile."oh-my-posh/config.json".source = lib.mkForce("/home/matpac/.config/oh-my-posh/config-fixed.json");
  # xdg.configFile."oh-my-posh/config.json".force = true;

  # home.sessionVariables.GTK_THEME = config.gtk.theme.name;
}
