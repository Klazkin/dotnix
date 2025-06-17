{ pkgs, ... }: {
  # Gnome
  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverridePackages = [ pkgs.mutter ];
      extraGSettingsOverrides =
        "  [org.gnome.desktop.peripherals.touchpad]\n  click-method='default'\n  # [org.gnome.mutter]\n  # experimental-features=['scale-monitor-framebuffer']\n";
    };
  };

  environment.gnome.excludePackages = (with pkgs; [
    atomix # puzzle game
    cheese # webcam tool
    epiphany # web browser
    evince # document viewer
    geary # email reader
    gedit # text editor
    gnome-characters
    gnome-music
    gnome-photos
    gnome-terminal
    gnome-tour
    xterm # xterm..
    hitori # sudoku game
    iagno # go game
    tali # poker game
    totem # video player
  ]);
}
