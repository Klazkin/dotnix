{ inputs, nixpkgs, home-manager, hostName, user, systemType ? "physical"
, serverType ? null, roles ? [ ], hmRoles ? [ ], extraImports ? [ ], ... }:
# Inspired by https://github.com/Baitinq/nixos-config/blob/31f76adafbf897df10fe574b9a675f94e4f56a93/hosts/default.nix
let
  commonNixOSModules = hostName: systemType: [
    # Set common config options
    {
      networking.hostName = hostName;
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
    }

    # Include our host specific config
    ./hosts/${systemType}/${hostName}

    # Absolute minimum config required
    ./base.nix

    # Include our shared configuration
    ./nixos/common

    # Add in sops
    inputs.sops-nix.nixosModules.sops
  ];

  mkNixRoles = roles: (map (n: ./nixos/roles/${n}) roles);
  mkHMRoles = roles: (map (n: ./home-manager/roles/${n}) roles);

  mkHost = hostName: user: systemType: serverType: roles: hmRoles: extraImports:
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules =
        # Shared modules
        commonNixOSModules hostName systemType
        # Add all our specified roles
        ++ mkNixRoles roles
        # Add all Home-Manager configurations + specified HM roles
        ++ [
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit inputs;
              inherit (inputs) nix-colors;
              inherit user;
            };

            home-manager.useUserPackages = true;
            home-manager.users.${user}.imports = [
              ./home.nix
              ./home-manager/common
            ]
            # Add specified home-manager roles
              ++ mkHMRoles hmRoles;
          }
        ];
      specialArgs = {
        inherit inputs;
        inherit user;
      };
    };
in mkHost hostName user systemType serverType roles hmRoles extraImports
