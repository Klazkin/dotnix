{ ... }: {
  # manjaro mount
  fileSystems."/mnt/manjaro" = {
    device = "/dev/nvme0n1p2";
    # options = [ "uid=1000" "gid=100" "dmask=007" "fmask=117" "nofail" ];
    options = [ "nofail" ];
  };
}
