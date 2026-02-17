{ pkgs, inputs, config, lib, ... }:

{
    options.mySystem.boot = {
        enableSecureBoot = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = "Whether to enable secure boot";
        };

        enablePlymouth = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = "Whether to enable the Plymouth bootsplash screen";
        };
    };

    imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

    config.boot = lib.mkMerge [
        {
            kernelPackages = pkgs.linuxPackages_latest;
            bootspec.enable = true;
            initrd.systemd.enable = true;

            loader = {
                efi.canTouchEfiVariables = true;
                systemd-boot.enable = true;
            };

            kernel.sysctl = {
                "kernel.sched_cfs_bandwidth_slice_us" = 3000;
                "net.ipv4.tcp_fin_timeout" = 5;
                "kernel.split_lock_mitigate" = 0;
                "vm.max_map_count" = 2147483642;
            };

            kernelParams = [
                # security stuff
                "rcupdate.rcu_expedited=1"
                "page_alloc.shuffle=1"
                # zswap
                "zswap.enabled=1"
                "zswap.compressor=zstd"
                "zswap.max_pool_percent=50"
                "zswap.shrinker_enabled=1"
            ];
        }

        (lib.mkIf config.mySystem.boot.enablePlymouth {
            plymouth = {
                enable = true;
                theme = lib.mkDefault "bgrt";
            };

            # Enable "Silent boot"
            consoleLogLevel = 4;
            initrd.verbose = false;

            loader = {
                timeout = 0;
                systemd-boot.enable = lib.mkForce false;
            };

            kernelParams = [
                # silent boot
                "quiet"
                "splash"
                "nowatchdog"
                "boot.shell_on_fail"
                "udev.log_priority=3"
                "rd.systemd.show_status=auto"
            ];
        })

        (lib.mkIf config.mySystem.boot.enableSecureBoot {
            lanzaboote = {
                enable = true;
                pkiBundle = "/var/lib/sbctl/";
                autoGenerateKeys.enable = true;
                autoEnrollKeys.enable = true;
            };
        })
    ];
}

# More work needs to be done if I want to enable secure boot.
# Here's a quick summary of what I need to do:
# sudo nix-shell -p sbctl
# sudo sbctl create-keys
# Clear all the secure boot keys in the UEFI and enable secure boot there
# sudo sbctl enroll-keys --microsoft
# Re-enable secure boot in UEFI if needed
