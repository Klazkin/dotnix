{ ... }: {
  # swap file config
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8 * 1024; # n * GiB
  }];
}
