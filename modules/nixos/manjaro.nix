{ ... }: {
  # Mounts my old Manjaro Partition
  fileSystems."/mnt/manjaro" = {
    device = "/dev/nvme0n1p2";
    options = [ "nofail" ];
  };
}
