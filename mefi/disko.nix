{
  disko.devices = {
    disk.main = {
      type = "disk";
      device = "/dev/disk/by-id/nvme-KXG60ZNV512G_TOSHIBA_20OA70EWK93L";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            type = "EF00";
            size = "250M";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };
          swap = {
            size = "8G";
            content.type = "swap";
          };
          root = {
            size = "50G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [ "noatime" ];
            };
          };
        };
      };
    };
  };
}
