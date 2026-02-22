{ lib, ... }:

{
    networking.useDHCP = lib.mkDefault true;
    boot.supportedFilesystems = lib.mkForce [ "ext4" "vfat" ];

    boot = {
        bootspec.enable = lib.mkForce false;
        loader.efi.canTouchEfiVariables = lib.mkForce false;
        initrd.systemd.enable = lib.mkForce false;
    };
}
