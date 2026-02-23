{ pkgs, ... }: {
  services.udev = {
    packages = with pkgs; [
      qmk
      qmk-udev-rules # the only relevant
      qmk_hid
      via
      vial
    ]; # packages
  };

  environment.systemPackages = with pkgs; [ qmk via ];
  hardware.keyboard.qmk.enable = true;
}
