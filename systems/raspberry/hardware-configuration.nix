{ lib, ... }:

{
    networking.useDHCP = lib.mkDefault true;
    boot.supportedFilesystems = lib.mkForce [ "ext4" "vfat" ];
}
