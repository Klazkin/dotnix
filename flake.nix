{
  # Inspired by https://certifikate.io/blog/posts/2024/12/creating-a-multi-system-modular-nixos-configuration-with-flakes/
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-24.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix/release-24.11";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix/24.11";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, ... }@inputs:
    let
      user = "matpac";

      systems = {
        # Framework 13 Laptop
        framework = {
          theme = {
            stylix = "";
            ghostty = "gruvbox";
            vscode = "";
          };

          nixModules = [
            /boot.nix
            /stylix.nix
            /steam.nix
            /manjaro.nix
            /zsh.nix
            /gnome.nix
          ];

          hmModules = [
            /ghostty.nix
            /glance.nix
            /gnome.nix
            /minecraft.nix
            /oh-my-posh.nix
            /spicetify.nix
            /vscode.nix
            /zed.nix
            /zsh.nix
          ];
        };

        # add new systems here
      };

      mkSystem = host: system:
        import ./hosts.nix ({
          inherit inputs;
          hostName = "${host}";
          user = system.user or user;
        } // system);
    in { nixosConfigurations = inputs.nixpkgs.lib.mapAttrs mkSystem systems; };
}
