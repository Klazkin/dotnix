{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-25.05 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix/release-25.05";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix/24.11";
  };

  outputs = { self, nixpkgs, stylix, spicetify-nix, ... }@inputs: { # home-manager, firefox-gnome-theme,
    # Please replace my-nixos with your hostname
    nixosConfigurations.nixos =
     let
      system = "x86_64-linux";

	  specialArgs = {
	    inherit inputs;
	  };

      modules = [
        stylix.nixosModules.stylix

        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix

        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.matpac = import ./home.nix;
          home-manager.extraSpecialArgs = specialArgs;
        }
      ];
     in
     nixpkgs.lib.nixosSystem { inherit system modules specialArgs; };
  };
}
