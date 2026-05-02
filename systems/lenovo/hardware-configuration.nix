{ config, lib, username, inputs, ... }:

{
    imports = [ inputs.disko.nixosModules.disko ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    hardware.enableRedistributableFirmware = lib.mkDefault true;

    boot = {
        kernelModules = [ "kvm-amd" ];
        initrd = {
            availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
            kernelModules = [ "dm-snapshot" ];
        };
    };

    # ZFS Stuff
    networking.hostId = "4e98920d";
    boot.zfs.forceImportRoot = false;
    services.zfs.autoScrub = {
        enable = true;
        interval = "monthly";
    };

    disko.devices = {
        disk = {
            ssd = {
                type = "disk";
                device = "/dev/disk/by-id/nvme-KBG40ZMT128G_TOSHIBA_MEMORY_31GPD8WJQXQ2";
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
                                name = "cryptssd";
                                content = {
                                    type = "zfs";
                                    pool = "ssd";
                                };
                            };
                        };
                    };
                };
            };

            hdd = {
                type = "disk";
                device = "/dev/disk/by-id/wwn-0x5000c500d69066f4";
                content = {
                    type = "gpt";
                    partitions.storage = {
                        size = "100%";
                        content = {
                            type = "luks";
                            name = "crypthdd";
                            content = {
                                type = "zfs";
                                pool = "hdd";
                            };
                        };
                    };
                };
            };
        };

        zpool = {
            ssd = {
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
                        postCreateHook = "zfs list -t snapshot -H -o name | grep -E '^ssd/local/root@blank$' || zfs snapshot ssd/local/root@blank";
                    };
                };
            };

            hdd = {
                type = "zpool";
                rootFsOptions = {
                    acltype = "posixacl";
                    atime = "off";
                    compression = "zstd";
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
                    "local/root" = {
                        type = "zfs_fs";
                        mountpoint = "/home/${username}/Documents/HDD";
                        options."com.sun:auto-snapshot" = "false";
                    };
                };
            };
        };
    };
}
