{ pkgs, ... }: {
  # https://apps.gnome.org/

  home.packages = with pkgs; [
    pinta # gtk styled paint
    celluloid # mpv video player
    amberol # music player
    dialect # translator
    fragments # torrent client
    impression # create boot drives
    iotas # notes
    keypunch # monkey type clone
    resources # desktop resources
  ];
}
