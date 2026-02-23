{ lib, pkgs, inputs, ... }:

{
    networking.useDHCP = lib.mkDefault true;
    hardware.enableAllHardware = lib.mkForce true;

    boot = {
        kernelPackages = lib.mkForce (pkgs.linuxPackagesFor
            (pkgs.callPackage "${inputs.nixos-hardware}/raspberry-pi/common/kernel.nix" { rpiVersion = 5; })
        );
        supportedFilesystems = lib.mkForce [ "ext4" "vfat" ];
        bootspec.enable = lib.mkForce false;
        loader.efi.canTouchEfiVariables = lib.mkForce false;
        initrd.systemd.enable = lib.mkForce false;
        blacklistedKernelModules = [ "dw-hdmi" ];
    };
}
