# https://nixos.wiki/wiki/Nvidia

{ config, ... }: {
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true; # saves vram to /tmp
    powerManagement.finegrained = false; # enable on Turing or newer
    open = false; # nvidia open driver, Turing or newer
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
