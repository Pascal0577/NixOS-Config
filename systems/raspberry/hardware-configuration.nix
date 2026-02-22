{
    fileSystems."/" = {
        device = "/dev/disk/by-label/nixos";
        fsType = "ext4";
    };

    fileSystems."/boot/firmware" = {
        device = "/dev/disk/by-label/FIRMWARE";
        fsType = "vfat";
    };

    networking.useDHCP = true;
}
