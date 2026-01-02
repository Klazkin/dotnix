{ pkgs, config, lib, theme, ... }:

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
      gsconnect
    ]);

  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        disabled-extensions = [ ];
        enabled-extensions = [
          "weatherornot@somepaulo.github.io"
          "appindicatorsupport@rgcjonas.gmail.com"
          "blur-my-shell@aunetx"
          "accent-directories@taiwbi.com"
          "system-monitor@gnome-shell-extensions.gcampax.github.com"
          "dash-to-panel@jderose9.github.com"
          "mediacontrols@cliffniff.github.com"
          "quick-settings-audio-panel@rayzeq.github.io"
          "gsconnect@andyholmes.github.io"
        ];

        favorite-apps = [ ];
      };

      "org/gnome/desktop/input-sources" = {
        sources = [
          (mkTuple [ "xkb" "us" ])
          (mkTuple [ "xkb" "ee" ])
          (mkTuple [ "xkb" "ru" ])
        ];
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
          "{'pipeline_default': {'name': <'PanelBlur'>, 'effects': <[<{'type': <'native_static_gaussian_blur'>, 'id': <'effect_000000000000'>, 'params': <{'radius': <30>, 'brightness': <1>, 'unscaled_radius': <20>}>}>]>}, 'pipeline_default_rounded': {'name': <'Overview'>, 'effects': <[<{'type': <'native_static_gaussian_blur'>, 'id': <'effect_31109415505246'>, 'params': <{'unscaled_radius': <20>, 'brightness': <0.29999999999999999>}>}>]>}}";
        settings-version = 2;
      };

      "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
        blur = true;
        brightness = 0.7;
        sigma = 20;
        style-dialogs = 1;
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
          "zen-beta"
          "org.gnome.FileRoller"
          "org.gnome.SystemMonitor"
          "org.gnome.Extensions"
          "org.gnome.TextEditor"
          "org.gnome.clocks"
          "org.gnome.Decibels"
          "org.gnome.Loupe"
          "org.gnome.Calculator"
          "com.github.PintaProject.Pinta"
          "org.gnome.Snapshot"
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
        "pipeline_default_rounded";

      "org/gnome/shell/extensions/blur-my-shell/overview" = {
        blur = true;
        pipeline = "pipeline_default_rounded";
        stlye-components = 2;
      };

      "org/gnome/shell/extensions/blur-my-shell/panel" = {
        blur = true;
        brightness = 1.0;
        force-light-text = false;
        override-background = false;
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
        brightness = 0.7;
        sigma = 20;
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
          PLANK = 3;
          SIMPLE = 1;
        };
        animate-appicon-hover-animation-rotation = builtins.toJSON {
          SIMPLE = 0;
          RIPPLE = 10;
          PLANK = 0;
        };
        animate-appicon-hover-animation-travel = builtins.toJSON {
          SIMPLE = 0.15;
          RIPPLE = 0.1;
          PLANK = 0.0;
        };
        animate-appicon-hover-animation-type = "SIMPLE";
        animate-appicon-hover-animation-zoom = builtins.toJSON {
          SIMPLE = 1.15;
          RIPPLE = 1.25;
          PLANK = 2.0;
        };
        appicon-margin = 4;
        appicon-padding = 4;
        appicon-style = "NORMAL";
        available-monitors = [ 0 ];
        desktop-line-use-custom-color = false;
        dot-color-dominant = true;
        dot-color-override = false;
        dot-color-unfocused-different = false;
        dot-position = "BOTTOM";
        dot-size = 1;
        dot-style-focused = "SEGMENTED";
        dot-style-unfocused = "SEGMENTED";
        extension-version = 72;
        focus-highlight-dominant = true;
        focus-highlight-opacity = 30;
        global-border-radius = 0;
        group-apps = true;
        group-apps-label-font-color = "#dddddd";
        group-apps-label-font-color-minimized = "#dddddd";
        group-apps-label-font-size = 14;
        group-apps-label-font-weight = "inherit";
        group-apps-label-max-width = 160;
        group-apps-underline-unfocused = true;
        group-apps-use-fixed-width = true;
        group-apps-use-launchers = false;
        hide-overview-on-startup = true;
        highlight-appicon-hover-background-color = "red";
        highlight-appicon-hover-border-radius = 4;
        highlight-appicon-pressed-background-color = "green";
        hot-keys = false;
        hotkeys-overlay-combo = "TEMPORARILY";
        intellihide = false;
        intellihide-animation-time = 200;
        intellihide-behaviour = "ALL_WINDOWS";
        intellihide-close-delay = 400;
        intellihide-enable-start-delay = 2000;
        intellihide-hide-from-monitor-windows = false;
        intellihide-hide-from-windows = false;
        intellihide-key-toggle = [ "<Super>i" ];
        intellihide-key-toggle-text = "<Super>i";
        intellihide-only-secondary = false;
        intellihide-persisted-state = -1;
        intellihide-pressure-threshold = 100;
        intellihide-pressure-time = 1000;
        intellihide-reveal-delay = 0;
        intellihide-revealed-hover = true;
        intellihide-revealed-hover-limit-size = false;
        intellihide-show-in-fullscreen = false;
        intellihide-show-on-notification = false;
        intellihide-use-pointer = true;
        intellihide-use-pointer-limit-size = false;
        intellihide-use-pressure = false;
        isolate-monitors = false;
        isolate-workspaces = false;
        leftbox-padding = -1;
        leftbox-size = 0;
        overview-click-to-exit = false;

        panel-anchors = ''
          {"0":"START", "1":"START"}
        '';

        panel-element-positions = ''
          {"1":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":false,"position":"stackedBR"}],"0":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"activitiesButton","visible":true,"position":"centerMonitor"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":false,"position":"stackedBR"}]}
        '';

        panel-lengths = ''
          {"0":100, "1":100}
        '';

        panel-positions = builtins.toJSON {
          "0" = "BOTTOM";
          "1" = "BOTTOM";
        };

        panel-sizes = builtins.toJSON {
          "0" = theme.panelSize;
          "1" = theme.panelSize;
        };

        panel-side-margins = 0;
        panel-side-padding = 4;
        panel-top-bottom-margins = 0;
        panel-top-bottom-padding = 0;
        peek-mode = true;
        prefs-opened = false;
        preview-custom-opacity = 0;
        preview-use-custom-opacity = true;
        primary-monitor = 0;
        progress-show-count = true;
        scroll-panel-delay = 200;
        show-favorites = false;
        show-favorites-all-monitors = true;
        show-running-apps = true;
        show-showdesktop-hover = false;
        show-tooltip = true;
        show-window-previews = true;
        show-window-previews-timeout = 200;
        showdesktop-button-width = 13;
        status-icon-padding = 4;
        stockgs-force-hotcorner = true;
        stockgs-keep-dash = false;
        stockgs-keep-top-panel = false;
        stockgs-panelbtn-click-only = false;
        trans-dynamic-anim-target = 0.7;
        trans-dynamic-anim-time = 250;
        trans-panel-opacity = 0.0;
        trans-bg-color = "#" + config.lib.stylix.colors.base00;
        trans-border-use-custom-color = true;
        trans-border-custom-color = "rgba(255,255,255,0.10)";
        trans-use-border = true;
        trans-use-custom-bg = true;
        trans-use-custom-gradient = false;
        trans-use-custom-opacity = true;
        trans-use-dynamic-opacity = true;
        tray-padding = 4;
        tray-size = 0;
        window-preview-animation-time = 200;
        window-preview-fixed-y = true;
        window-preview-padding = 16;
        window-preview-show-title = false;
        window-preview-size = 240;
        window-preview-title-position = "BOTTOM";
      };

      "org/gnome/desktop/interface" = {
        # color-scheme = "prefer-dark"; # handeled by stylx
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
