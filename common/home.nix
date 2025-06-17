{ pkgs, inputs, user, ... }: {

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
  home.stateVersion = "24.11";

  fonts.fontconfig.enable = true;

  programs.firefox = { enable = true; };

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

    discord
    pinta
    godot_4
    bottles # sandboxed wine environments
    nixd # nix language server
    nil # also a nix lang server
    nixfmt # nix formatter

    inputs.zen-browser.packages."${system}".default

  ];

  programs.bat = { enable = true; };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
