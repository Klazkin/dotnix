{ inputs, user, ... }:

let
  system = "x86_64-linux";

  modules = [
    inputs.stylix.nixosModules.stylix

    # Import the previous configuration.nix we used,
    # so the old configuration file still takes effect
    ./configuration.nix # todo move configuration to here

    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user}.imports = [
        ./home.nix

        ./modules/home-manager/vscode.nix
      ];

      home-manager.extraSpecialArgs = {
        inherit inputs;
        inherit user;
      };
    }

  ];
in inputs.nixpkgs.lib.nixosSystem { inherit system modules; }
