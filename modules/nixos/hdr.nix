{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ vulkan-hdr-layer-kwin6 ];
}
