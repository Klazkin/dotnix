{ inputs, config, ... }: {
  imports = [ inputs.nixcord.homeModules.nixcord ];

  programs.nixcord = {
    enable = true; # Enable Nixcord (It also installs Discord)
    # vesktop.enable = true; # Vesktop
    # dorion.enable = true; # Dorion
    # quickCss = ''
    #   :root {
    #       --base00: transparent;
    #       --base01: transparent;
    #   }

    #   :root {
    #     background-color: #${config.lib.stylix.colors.base00}b3;
    #   }
    # ''; # quickCSS file

    #     background-color: #171b24b3;
    config = {
      # useQuickCss = true; # use out quickCSS
      # themeLinks = [ # or use an online theme
      #   "https://raw.githubusercontent.com/link/to/some/theme.css"
      # ];
      # frameless = true; # Set some Vencord options
      # transparent = true;
      # plugins = {
      #   hideAttachments.enable = true; # Enable a Vencord plugin
      #   ignoreActivities = { # Enable a plugin and set some options
      #     enable = true;
      #     ignorePlaying = true;
      #     ignoreWatching = true;
      #     ignoredActivities = [ "someActivity" ];
      #   };
      # };
    };
    # dorion = {
    #   theme = "dark";
    #   zoom = "1.1";
    #   blur = "acrylic"; # "none", "blur", or "acrylic"
    #   sysTray = true;
    #   openOnStartup = true;
    #   autoClearCache = true;
    #   disableHardwareAccel = false;
    #   rpcServer = true;
    #   rpcProcessScanner = true;
    #   pushToTalk = true;
    #   pushToTalkKeys = [ "RControl" ];
    #   desktopNotifications = true;
    #   unreadBadge = true;
    # };
    # extraConfig = {
    #   # Some extra JSON config here
    #   # ...
    # };
  };
}
