{ config, lib, modulesPath, ... }:

{
    imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "sd_mod" ];
    boot.initrd.kernelModules = [ "dm-snapshot" ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    boot.initrd.luks.devices = {
        root = {
            device = "/dev/disk/by-uuid/e66aa624-e1c3-4f8a-9908-03d3ffedee8d";
            preLVM = true;
        };
    };

    fileSystems."/" = {
        device = "/dev/mapper/vg0-root";
        fsType = "ext4";
    };

    fileSystems."/boot" = { 
        device = "/dev/disk/by-uuid/7998-BD7F";
        fsType = "vfat";
        options = [ "fmask=0022" "dmask=0022" ];
    };

    swapDevices = [
        { device = "/dev/mapper/vg0-swap"; }
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
