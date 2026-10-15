# patches for getting steamframe to work
{ pkgs, ... }: {

  networking.networkmanager = {
    wifi.backend = "iwd"; # or "wpa_supplicant";
    unmanaged = [ ]; # Ensure NM isn't explicitly ignoring USB dongles
    wifi.powersave = false; # for desktop and steam frame dongle
  };

  # latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelPatches = [{
    name = "amdgpu-ignore-ctx-privileges";
    patch = pkgs.fetchpatch {
      name = "cap_sys_nice_begone.patch";
      url =
        "https://github.com/Frogging-Family/community-patches/raw/master/linux61-tkg/cap_sys_nice_begone.mypatch";
      hash = "sha256-Y3a0+x2xvHsfLax/uwycdJf3xLxvVfkfDVqjkxNaYEo=";
    };
  }];
}
