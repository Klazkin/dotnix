{
  description = "A simple NixOS flake";
  # based on https://certifikate.io/blog/posts/2024/12/creating-a-multi-system-modular-nixos-configuration-with-flakes/

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

  outputs = { self, ... }@inputs: {

    # commonInherits = { inherit inputs; };

    # user = "matpac";

    # systems = {
    # framework = {
    #   modules = {

    #   };
    # };

    # desktop = {
    #   modules = {

    #   };
    # };
    # };

    # mkSystem = host: system:
    #   import ./hosts.nix (commonInherits // {
    #     hostName = "${host}";
    #     user = system.user or user;
    #   } // system);

    nixosConfigurations.framework = let
      system = "x86_64-linux";

      specialArgs = { inherit inputs; };

      modules = [
        inputs.stylix.nixosModules.stylix

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
    in inputs.nixpkgs.lib.nixosSystem { inherit system modules specialArgs; };
  };
}
