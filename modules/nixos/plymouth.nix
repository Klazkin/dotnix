{ pkgs, ... }: {
  boot = {
    plymouth = {
      enable = true;
      theme = "bgrt"; # handeled by stylix
      themePackages = with pkgs;
        [
          # By default we would install all themes
          (adi1090x-plymouth-themes.override {
            selected_themes = [ "loader_2" ];
          })
        ];
    };
  };
}
