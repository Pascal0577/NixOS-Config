{ lib, nixos-raspberrypi, ... }:

{
    hardware.enableAllHardware = lib.mkForce false;

    boot = {
        kernelPackages =
            lib.mkForce nixos-raspberrypi.packages.aarch64.linuxPackages_rpi5;
        bootspec.enable = lib.mkForce false;
        loader.efi.canTouchEfiVariables = lib.mkForce false;
        loader.systemd-boot.enable = lib.mkForce false;
        initrd.systemd.enable = lib.mkForce false;
    };
}
