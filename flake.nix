{
  # Inspired by https://certifikate.io/blog/posts/2024/12/creating-a-multi-system-modular-nixos-configuration-with-flakes/
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-24.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix/release-25.05";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = { url = "github:kaylorben/nixcord"; };
  };

  outputs = { self, ... }@inputs:
    let
      user = "matpac";

      systems = {
        # Framework 13 Laptop
        framework = {
          theme = {
            stylix = "gruvbox-dark-hard";
            ghostty = "GruvboxDarkHard";
            vscode = "Gruvbox Material Dark";
            zed = "Gruvbox Dark Hard";
            wallpaper = ./wallpapers/manjaro.jpg;
            fontSize = 12;
            panelSize = 48;
            cursorSize = 32;
          };

          nixModules = [
            /boot.nix
            /gnome.nix
            /manjaro.nix
            /steam.nix
            /stylix.nix
            /zsh.nix
            /systemd-boot.nix
          ];

          hmModules = [
            /discord.nix
            /ghostty.nix
            /glance.nix
            /gnome.nix
            /minecraft.nix
            /oh-my-posh.nix
            /spicetify.nix
            /vscode.nix
            /zed.nix
            /zen.nix
            /zsh.nix
          ];
        };

        # Home Desktop PC
        desktop = {
          theme = {
            stylix = "ayu-mirage";
            ghostty = "Ayu Mirage";
            vscode = "Ayu Mirage Bordered";
            zed = "Ayu Mirage";
            wallpaper = ./wallpapers/pexels-photo-772803-modifed.jpeg;
            fontSize = 10;
            panelSize = 32;
            cursorSize = 24;
          };

          nixModules = [
            /boot.nix
            /gnome.nix
            /stylix.nix
            /zsh.nix
            /grub.nix
            /coolercontrol.nix
            /nvidia.nix
          ];

          hmModules = [
            /discord.nix
            /ghostty.nix
            /spicetify.nix
            /zen.nix
            /gnome.nix
            /oh-my-posh.nix
            /vscode.nix
            /zed.nix
            /zsh.nix
            /jetbrains.nix
          ];
        };
      };

      mkSystem = host: system:
        import ./hosts.nix ({
          inherit inputs;
          hostName = "${host}";
          user = system.user or user;
          theme = system.theme;
        } // system);
    in { nixosConfigurations = inputs.nixpkgs.lib.mapAttrs mkSystem systems; };
}
