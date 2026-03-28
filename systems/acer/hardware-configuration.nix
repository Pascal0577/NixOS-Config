{ config, lib, pkgs, inputs, username, ... }:

{
    imports = [ inputs.disko.nixosModules.disko ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    services.xserver.videoDrivers = [ "modesetting" "nvidia" ];
    hardware = {
        cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
        graphics.extraPackages = [ pkgs.intel-media-driver ];
        enableRedistributableFirmware = lib.mkDefault true;
        nvidia = {
            open = true;
            modesetting.enable = true;
            nvidiaSettings = false;
            powerManagement.enable = false;
            powerManagement.finegrained = false;
            dynamicBoost.enable = true;
            prime = {
                sync.enable = true;
                intelBusId = "PCI:0:2:0";
                nvidiaBusId = "PCI:1:0:0";
            };
        };
    };

    boot = {
        binfmt.emulatedSystems = [ "aarch64-linux" ];
        kernelModules = [ "kvm-intel" ];
        kernelParams = [
            "i915.enable_guc=3"
            "i915.enable_fbc=1"
            "intel_iommu=on"
            "iommu=pt"
        ];
        initrd = {
            availableKernelModules = [ "vmd" "xhci_pci" "thunderbolt" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
            kernelModules = [ "i915" "dm-snapshot" ];
        };
    };

    # ZFS Stuff
    networking.hostId = "5eafa8c8";
    services.zfs.autoScrub = {
        enable = true;
        interval = "monthly";
    };

    disko.devices = {
        disk = {
            main = {
                type = "disk";
                device = "/dev/disk/by-id/nvme-HFS512GEJ9X125N_SYC2N009317202F4F";
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
                            size = "8G";
                            content = {
                                type = "swap";
                                randomEncryption = true;
                            };
                        };
                        root = {
                            size = "100%";
                            content = {
                                type = "luks";
                                name = "cryptroot";
                                settings.allowDiscards = true;
                                settings.bypassWorkqueues = true;
                                content = {
                                    type = "zfs";
                                    pool = "zroot";
                                };
                            };
                        };
                    };
                };
            };
        };
        zpool = {
            zroot = {
                type = "zpool";
                rootFsOptions = {
                    acltype = "posixacl";
                    atime = "off";
                    compression = "lz4";
                    mountpoint = "none";
                    xattr = "sa";
                    dnodesize = "auto";
                };
                options = {
                    ashift = "12";
                    autotrim = "on";
                };

                datasets = {
                    "local" = {
                        type = "zfs_fs";
                        options.mountpoint = "none";
                    };
                    "local/home" = {
                        type = "zfs_fs";
                        mountpoint = "/home";
                        options."com.sun:auto-snapshot" = "true";
                    };
                    "local/vms" = {
                        type = "zfs_fs";
                        mountpoint = "/home/${username}/Machines";
                        options = {
                            # optimize for big files
                            recordsize = "1M";
                            primarycache = "metadata";
                            logbias = "throughput";
                            secondarycache = "none";
                            sync = "disabled";
                            redundant_metadata = "most";
                            "com.sun:auto-snapshot" = "false";
                        };
                    };
                    "local/nix" = {
                        type = "zfs_fs";
                        mountpoint = "/nix";
                        options = {
                            # Nix store has lots of small files
                            recordsize = "64K";
                            "com.sun:auto-snapshot" = "false";
                        };
                    };
                    "local/persist" = {
                        type = "zfs_fs";
                        mountpoint = "/nix/persist";
                        options."com.sun:auto-snapshot" = "false";
                    };
                    "local/root" = {
                        type = "zfs_fs";
                        mountpoint = "/";
                        options."com.sun:auto-snapshot" = "false";
                        postCreateHook = "zfs list -t snapshot -H -o name | grep -E '^zroot/local/root@blank$' || zfs snapshot zroot/local/root@blank";
                    };
                };
            };
        };
    };
}
