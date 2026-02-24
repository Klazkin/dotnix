{ inputs, user, hostName, nixModules ? [ ], hmModules ? [ ], theme, ... }:

let
  specialArgs = {
    inherit inputs;
    inherit user;
    inherit hostName;
    inherit theme;
  };

  mkNixModules = modules: (map (n: ./modules/nixos/${n}) modules);

  mkHomeManagerModules = modules:
    (map (n: ./modules/home-manager/${n}) modules);

  modules = mkNixModules nixModules ++ [

    ./hosts/${hostName}/hardware-configuration.nix

    ./common/configuration.nix

    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = specialArgs;
      home-manager.users.${user}.imports = [ ./common/home.nix ]
        ++ mkHomeManagerModules hmModules;
    }
  ];
in inputs.nixpkgs.lib.nixosSystem { inherit modules specialArgs; }
