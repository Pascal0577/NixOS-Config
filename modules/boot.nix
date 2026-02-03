{ pkgs, inputs, lib, ... }:

{
    imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
    boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        bootspec.enable = true;

        kernel.sysctl = {
            "kernel.sched_cfs_bandwidth_slice_us" = 3000;
            "net.ipv4.tcp_fin_timeout" = 5;
            "kernel.split_lock_mitigate" = 0;
            "vm.max_map_count" = 2147483642;
        };

        plymouth = {
            enable = true;
            theme = lib.mkDefault "bgrt";
        };

        lanzaboote = {
            enable = true;
            pkiBundle = "/var/lib/sbctl/";
        };

        # Enable "Silent boot"
        consoleLogLevel = 4;
        initrd = {
            verbose = false;
            systemd.enable = true;
        };

        kernelParams = [
            # silent boot
            "quiet"
            "splash"
            "nowatchdog"
            "boot.shell_on_fail"
            "udev.log_priority=3"
            "rd.systemd.show_status=auto"
            # security stuff
            "rcupdate.rcu_expedited=1"
            "page_alloc.shuffle=1"
            # zswap
            "zswap.enabled=1"
            "zswap.compressor=zstd"
            "zswap.max_pool_percent=50"
            "zswap.shrinker_enabled=1"
        ];

        loader = {
            timeout = 0;
            efi.canTouchEfiVariables = true;
        };
    };
}

# More work needs to be done if I want to enable secure boot.
# Here's a quick summary of what I need to do:
# sudo nix-shell -p sbctl
# sudo sbctl create-keys
# Clear all the secure boot keys in the UEFI and enable secure boot there
# sudo sbctl enroll-keys --microsoft
# Re-enable secure boot in UEFI if needed
