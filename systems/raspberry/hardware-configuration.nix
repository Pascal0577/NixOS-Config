{ lib, nixos-raspberrypi, ... }:

{
    hardware.enableAllHardware = lib.mkForce false;

    boot = {
        kernelPackages =
            lib.mkForce nixos-raspberrypi.packages.aarch64-linux.linuxPackages_rpi5;
        bootspec.enable = lib.mkForce false;
        loader.efi.canTouchEfiVariables = lib.mkForce false;
        loader.systemd-boot.enable = lib.mkForce false;
        initrd.systemd.enable = lib.mkForce false;
    };

    hardware.raspberr-pi.extra-config = ''
        arm_freq=3000
        gpu_freq=1000
        over_voltage_delta=50000
    '';
}
