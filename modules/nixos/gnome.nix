{ pkgs, ... }: {

  # Gnome
  services.desktopManager.gnome = {
    enable = true;
    extraGSettingsOverridePackages = [ pkgs.mutter ];
    extraGSettingsOverrides =
      "  [org.gnome.desktop.peripherals.touchpad]\n  click-method='default'\n  # [org.gnome.mutter]\n  # experimental-features=['scale-monitor-framebuffer']\n";
  };

  # Gnome Display Manager
  services.displayManager.gdm.enable = true;

  # disable gnome games
  services.gnome.games.enable = false;

  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/desktop-managers/gnome.nix#L449-L471
  environment.gnome.excludePackages = with pkgs; [
    ### Excluded apps
    epiphany # web
    gnome-text-editor
    gnome-calculator
    gnome-calendar
    gnome-console
    gnome-tour # tour of new features
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
