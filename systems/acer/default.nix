{ pkgs, config, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules
        ../../modules/themes/everforest.nix
    ];

    desktop.cosmic = {
        enable = true;
        accentRed = "${config.lib.stylix.colors.base09-dec-r}";
        accentGreen = "${config.lib.stylix.colors.base09-dec-g}";
        accentBlue = "${config.lib.stylix.colors.base09-dec-b}";
    };
    terminal.foot.enable = true;
    applications.swayidle.enable = false;

    services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

    programs.obs-studio.package = (
        pkgs.obs-studio.override {
            cudaSupport = true;
            # If we're compiling from source we might as well apply optimizations
            stdenv = pkgs.stdenvAdapters.withCFlags [
                "-O3"
                "-march=native"
                "-mtune=native"
                "-fomit-frame-pointer"
                "-flto"
            ] pkgs.stdenv;
        }
    );

    hardware = {
        graphics.extraPackages = [ pkgs.intel-media-driver ];
        nvidia = {
            open = false;
            modesetting.enable = true;
            nvidiaSettings = false;
            powerManagement.enable = false;
            powerManagement.finegrained = false;
            prime = {
                sync.enable = true;
                intelBusId = "PCI:0:2:0";
                nvidiaBusId = "PCI:1:0:0";
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
