{ inputs, ... }: {
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
}
