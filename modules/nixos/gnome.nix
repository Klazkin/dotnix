{ pkgs, ... }: {
  # Gnome
  services = {
    xserver = {
      displayManager.gdm.enable = true;
      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverridePackages = [ pkgs.mutter ];
        extraGSettingsOverrides =
          "  [org.gnome.desktop.peripherals.touchpad]\n  click-method='default'\n  # [org.gnome.mutter]\n  # experimental-features=['scale-monitor-framebuffer']\n";
      };
    };

    # disable games
    gnome.games.enable = false;
  };

  environment.gnome.excludePackages = with pkgs; [
    ### Excluded apps
    epiphany # web
    gnome-text-editor
    gnome-calculator
    gnome-calendar
    gnome-console
    gnome-contacts
    gnome-maps
    gnome-music
    gnome-connections # remote desktop
    showtime # video player
    simple-scan # document scanner
    yelp # gnome help
    decibels # music

    ### Included Apps

    # baobab # extension-manager
    # gnome-characters
    # gnome-clocks
    # gnome-font-viewer
    # gnome-logs
    # gnome-system-monitor
    # gnome-weather
    # loupe # image viewer
    # nautilus # file manager
    # papers # document viewer
    # snapshot # webcam
  ];
}
