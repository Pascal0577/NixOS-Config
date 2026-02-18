{ pkgs, config, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules
        ../../modules/themes/everforest.nix
    ];

    mySystem = {
        desktop.niri.enable = false;
        desktop.oxwm.enable = true;
        desktop.cosmic = {
            enable = false;
            accentColor = "${config.lib.stylix.colors.base09-hex}";
            accentRed = "${config.lib.stylix.colors.base09-dec-r}";
            accentGreen = "${config.lib.stylix.colors.base09-dec-g}";
            accentBlue = "${config.lib.stylix.colors.base09-dec-b}";
            cosmicOnNiri.enable = false;
        };

        applications = {
            noctalia.enable = false;
            swayidle.enable = false;
            launcher.vicinae.enable = false;
            launcher.dmenu.enable = true;
            terminal.foot.enable = false;
            terminal.alacritty.enable = true;
            file-manager.yazi.enable = true;
        };
    };

    services.displayManager.ly.enable = true;

    programs.obs-studio.package = (
        pkgs.obs-studio.override {
            cudaSupport = true;
            # If we're compiling from source we might as well apply optimizations
            stdenv = pkgs.stdenvAdapters.withCFlags [
                "-O3"
                "-march=native"
                "-fomit-frame-pointer"
                "-flto=auto"
                "-ffat-lto-objects"
                "-fdebug-types-section"
                "-femit-struct-debug-baseonly"
                "-g1"
                "-gno-column-info"
                "-gno-variable-location-views"
            ] pkgs.stdenv;
        }
    );

    services.xserver.videoDrivers = [ "modesetting" "nvidia" ];
    hardware = {
        graphics.extraPackages = [ pkgs.intel-media-driver ];
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
            package =
            let
                base = config.boot.kernelPackages.nvidiaPackages.latest;
                cachyos-nvidia-patch = pkgs.fetchpatch {
                    url = "https://raw.githubusercontent.com/CachyOS/CachyOS-PKGBUILDS/master/nvidia/nvidia-utils/kernel-6.19.patch";
                    sha256 = "sha256-YuJjSUXE6jYSuZySYGnWSNG5sfVei7vvxDcHx3K+IN4=";
                };

                # Patch the appropriate driver based on config.hardware.nvidia.open
                driverAttr = if config.hardware.nvidia.open then "open" else "bin";
            in
            base
            // {
                ${driverAttr} = base.${driverAttr}.overrideAttrs (oldAttrs: {
                    patches = (oldAttrs.patches or [ ]) ++ [ cachyos-nvidia-patch ];
                });
            };
        };
    };

    boot = {
        initrd.kernelModules = [ "i915" ];
        kernelParams = [
            "i915.enable_guc=3"
            "i915.enable_fbc=1"
        ];
    };
}
