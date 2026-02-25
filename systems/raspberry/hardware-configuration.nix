{ lib, pkgs, nixos-raspberrypi, ... }:

{
    networking.useDHCP = lib.mkDefault true;
    hardware.enableAllHardware = lib.mkForce false;

    boot = {
        kernelPackages = lib.mkForce nixos-raspberrypi.packages.${pkgs.stdenv.hostPlatform.system}.linuxPackages_rpi5;
        bootspec.enable = lib.mkForce false;
        loader.efi.canTouchEfiVariables = lib.mkForce false;
        initrd.systemd.enable = lib.mkForce false;
    };
}
