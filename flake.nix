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
          modules = [ ];
          hmModules = [
            ./modules/home-manager/vscode.nix
            ./modules/home-manager/zed.nix
            ./modules/home-manager/glance.nix
            ./modules/home-manager/ghostty.nix
            ./modules/home-manager/zsh.nix
            ./modules/home-manager/oh-my-posh.nix
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
