{ pkgs, user, inputs, ... }: {

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = user;
  home.homeDirectory = "/home/${user}";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  fonts.fontconfig.enable = true;

  programs.mangohud.enable = true;

  programs.firefox = {
    enable = true;

    profiles.default = {
      # TODO wait till extensions can be auto-enabled and fix the default search engine
      # id = 0;
      # name = "default";
      # isDefault = true;

      # settings = {
      # "browser.search.defaultenginename" = "ddg";
      #   "extensions.autoDisableScopes" = 0;
      #   "extensions.update.autoUpdateDefault" = false;
      #   "extensions.update.enabled" = false;
      # };

      # search = { default = "ddg"; };

      # extensions.force = true;

      #  nix flake show "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons"
      extensions.packages =
        with inputs.firefox-addons.packages."x86_64-linux"; [
          ublock-origin
          youtube-shorts-block
          duckduckgo-privacy-essentials
        ];
    };
  };

  stylix.targets.firefox.profileNames = [ "default" ];

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

  home.packages = with pkgs; [
    montserrat
    fastfetch
    lazygit

    pinta
    nixd # nix language server
    nil # also a nix lang server
    nixfmt-classic # nix formatter

    evince # pdf viewer
  ];

  programs.bat = { enable = true; };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
