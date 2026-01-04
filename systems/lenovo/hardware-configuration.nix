{ config, lib, modulesPath, ... }:

{
    imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ "dm-snapshot" ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    boot.initrd.luks.devices.root = {
        device = "/dev/disk/by-uuid/e66aa624-e1c3-4f8a-9908-03d3ffedee8d";
        preLVM = true;
    };

    fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/7998-BD7F";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
    };

    fileSystems."/" = { device = "/dev/disk/by-uuid/4eb773d6-e158-40e0-9f34-f629e94fa421";
        fsType = "xfs";
    };

    swapDevices = [
        { device = "/dev/disk/by-uuid/c1d7d20a-7857-4a1d-8987-f3cd81b26a2f"; }
    ];

    networking.useDHCP = lib.mkDefault true;
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
