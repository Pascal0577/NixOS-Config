{ pkgs, inputs, config, lib, ... }:
let
    boot = config.mySystem.boot;
    zfs = config.mySystem.ZFS;

    zfsCompatibleKernelPackages = lib.filterAttrs (
        name: kernelPackages:
        (builtins.match "linux_[0-9]+_[0-9]+" name) != null
        && (builtins.tryEval kernelPackages).success
        && (!kernelPackages.${config.boot.zfs.package.kernelModuleAttribute}.meta.broken)
    ) pkgs.linuxKernel.packages;

    latestZfsKernel = lib.last (
        lib.sort (a: b: (lib.versionOlder a.kernel.version b.kernel.version)) (
            builtins.attrValues zfsCompatibleKernelPackages
        )
    );
in
{
    options.mySystem = {
        boot = {
            enableSecureBoot =
                lib.mkEnableOption "Enable secure boot"
                // { default = !config.mySystem.server.enable; };

            enablePlymouth =
                lib.mkEnableOption "Enable Plymouth for pretty bootsplash"
                // { default = !config.mySystem.server.enable; };
        };

        ZFS.enable = lib.mkEnableOption "enableZfs";
    };

    imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

    config.boot = lib.mkMerge [
        {
            kernelPackages = lib.mkDefault (if zfs.enable
                then latestZfsKernel
                else pkgs.linuxPackages_latest);

            bootspec.enable = true;
            initrd.systemd.enable = true;
            supportedFilesystems = lib.mkIf zfs.enable [ "zfs" ];

            loader = {
                efi.canTouchEfiVariables = true;
                systemd-boot.enable = true;
            };

            kernel.sysctl = {
                "kernel.sched_cfs_bandwidth_slice_us" = 3000;
                "net.ipv4.tcp_fin_timeout" = 5;
                "vm.max_map_count" = 2147483642;
            };

            kernelParams = [
              # security stuff
              "rcupdate.rcu_expedited=1"
              "page_alloc.shuffle=1"
            ] ++ (lib.optionals (!zfs.enable) [
              # zswap if we aren't using zfs
              "zswap.enabled=1"
              "zswap.compressor=zstd"
              "zswap.max_pool_percent=50"
              "zswap.shrinker_enabled=1"
            ]);
        }

        (lib.mkIf boot.enablePlymouth {
            plymouth = {
                enable = true;
                theme = lib.mkDefault "bgrt";
            };

            # silent boot
            consoleLogLevel = 4;
            initrd.verbose = false;
            loader.timeout = 0;

            kernelParams = [
                "quiet"
                "splash"
                "nowatchdog"
                "boot.shell_on_fail"
                "udev.log_priority=3"
                "rd.systemd.show_status=auto"
            ];
        })

        (lib.mkIf boot.enableSecureBoot {
            loader.systemd-boot.enable = lib.mkForce false;
            lanzaboote = {
                enable = true;
                pkiBundle = "/var/lib/sbctl";
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
