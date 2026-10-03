{ config, inputs, lib, pkgs, ... }: {

  imports = [ inputs.noctalia.nixosModules.default ];

  environment.systemPackages = [ pkgs.xwayland-satellite ];
  #   [ inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default ];

  programs.niri = { enable = true; };
  programs.noctalia.enable = true;

  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${config.programs.niri.package}/bin/niri-session";
  #       user = "matpac";
  #     };
  #   };
  # };

  programs.xwayland.enable = true; # for steam?

}
