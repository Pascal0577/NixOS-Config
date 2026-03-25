{ inputs, lib, ... }:

{
    imports = [ inputs.disko.nixosModules.disko ];

    nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
    hardware.enableRedistributableFirmware = lib.mkDefault false;
    boot = {
        kernelModules = [ "kvm-arm64" ];
        initrd.availableKernelModules = [
            "xhci_pci"
            "virtio_pci"
            "virtio_scsi"
            "usbhid"
        ];
    };

    # ZFS
    networking.hostId = "bb482cb9";
    services.zfs.autoScrub = {
        enable = true;
        interval = "monthly";
    };

    disko.devices = {
        disk = {
            main = {
                type = "disk";
                device = ""; # fill out later
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
                        root = {
                            size = "100%";
                            content = {
                                type = "zfs";
                                pool = "zroot";
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
                    "local/nix" = {
                        type = "zfs_fs";
                        mountpoint = "/nix";
                        # Nix store has lots of small files
                        options.recordsize = "64K";
                    };
                    "local/persist" = {
                        type = "zfs_fs";
                        mountpoint = "/nix/persist";
                    };
                    "local/root" = {
                        type = "zfs_fs";
                        mountpoint = "/";
                        postCreateHook = "zfs list -t snapshot -H -o name | grep -E '^zroot/local/root@blank$' || zfs snapshot zroot/local/root@blank";
                    };
                };
            };
        };
    };
}
