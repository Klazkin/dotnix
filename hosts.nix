{ inputs, user, hostName, wipModules ? [ ], hmModules ? [ ], ... }:

let
  system = "x86_64-linux";

  specialArgs = {
    inherit inputs;
    inherit user;
    inherit hostName;
  };

  mkHomeManagerModules = modules: (map (n: ./modules/${n}/home.nix) modules);
  # mkNixModules = module: (map: );

  modules = [

    inputs.stylix.nixosModules.stylix

    ./configuration.nix

    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = specialArgs;
      home-manager.users.${user}.imports = [ ./home.nix ] ++ hmModules
        ++ mkHomeManagerModules wipModules;
    }

  ];
in inputs.nixpkgs.lib.nixosSystem { inherit system modules specialArgs; }
