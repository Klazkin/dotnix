{ ... }: {
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 9 * 1024; # n * GiB
  }];
}
