{ inputs, user, hostName, modules ? [ ], hmModules ? [ ], ... }:

let
  system = "x86_64-linux";

  modules = [

    inputs.stylix.nixosModules.stylix

    ./configuration.nix

    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user}.imports = [ ./home.nix ] ++ hmModules;

      home-manager.extraSpecialArgs = {
        inherit inputs;
        inherit user;
        inherit hostName;
      };
    }

  ];
in inputs.nixpkgs.lib.nixosSystem { inherit system modules; }
