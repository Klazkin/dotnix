{ inputs, pkgs, ... }: {

  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify =
    let spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [ shuffle ];
      enabledCustomApps = with spicePkgs.apps; [ newReleases ncsVisualizer ];
      # theme = spicePkgs.themes.catppuccin; # managed by stylix
    };
}
