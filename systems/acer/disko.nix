{ username, inputs, ... }:

{
    imports = [ inputs.disko.nixosModules.disko ];

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
                            content.type = "swap";
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
                options.ashift = "12";

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
                        mountpoint = "/persist";
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
