{ pkgs, config, lib, ... }:

with lib.hm.gvariant;

{
  home.packages = with pkgs;
    [ dconf-editor gnome-tweaks gnome-settings-daemon ]
    ++ (with pkgs.gnomeExtensions; [
      appindicator
      blur-my-shell
      accent-directories
      dash-to-panel
      weather-or-not
      media-controls
      quick-settings-audio-panel
    ]);

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
          "wofi"
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

      "org/gnome/shell/extensions/system-monitor" = {
        show-cpu = false;
        show-download = true;
        show-memory = false;
        show-swap = false;
        show-upload = false;
      };
    };
  };

  gtk = {
    enable = true;

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

  stylix.targets.gtk.extraCss = ''
    @define-color window_bg_color #${config.lib.stylix.colors.base00}b3;

    window {
       background-color: #${config.lib.stylix.colors.base00}b3;
    }
  '';
}
