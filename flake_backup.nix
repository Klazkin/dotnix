{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-24.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    firefox-gnome-theme = { url = "github:rafaelmardojai/firefox-gnome-theme"; flake = false; };
  };

  outputs = { self, nixpkgs, home-manager, firefox-gnome-theme, ... }@inputs: {
    # Please replace my-nixos with your hostname
    nixosConfigurations.nixos-framework = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

	  specialArgs = {
	    inherit firefox-gnome-theme;
	  };
	  
      
      modules = [

        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix
        
        home-manager.nixosModules.home-manager
        {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.matpac = import ./home.nix;
                    home-manager.extraSpecialArgs = specialArgs;
        }
      ];
    };
  };
}
