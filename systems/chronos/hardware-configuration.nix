{ inputs, ... }:

{
    imports = [ inputs.disko.nixosModules.disko ];

    nixpkgs.hostPlatform = "x86_64-linux";
    hardware.enableRedistributableFirmware = true;

    boot = {
        initrd.systemd.enable = true;
        loader.systemd-boot.enable = true;
        
        kernelParams = [
            "amdgpu.dc=0"
            "iommu=soft"
            "rootflags=noflush_merge"
        ];

        initrd.kernelModules = [
            "f2fs"
            "fam15h_power"
            "mmc_block"
            "mmc_core"
            "rpmb-core"
            "sdhci_pci"
        ];
    };

    disko.devices = {
        disk.main = {
            type = "disk";
            device = "/dev/disk/by-id/mmc-MMC32G_0x00136833";
            content = {
                type = "gpt";
                partitions = {
                    ESP = {
                        size = "1G";
                        type = "EF00";
                        content = {
                            type = "filesystem";
                            format = "vfat";
                            mountpoint = "/boot";
                            mountOptions = [ "umask=0077" ];
                        };
                    };

                    swap = {
                        size = "4G";
                        content.type = "swap";
                    };

                    root = {
                        size = "100%";
                        content = {
                            type = "filesystem";
                            format = "f2fs";
                            mountpoint = "/";
                            mountOptions = [
                                "compress_algorithm=lz4"
                                "compress_chksum"
                                "atgc"
                                "gc_merge"
                                "lazytime"
                            ];
                        };
                    };
                };
            };
        };
    };
}
