{ pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules
        ../../modules/applications/heroic.nix
        ../../modules/applications/oxwm
        ../../modules/themes/everforest.nix
    ];

    services.xserver.videoDrivers = [ "modesetting" "nvidia" ];
    services.printing.enable = true;

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
        bluetooth.enable = true;
        nvidia = {
            open = true;
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

        graphics = {
            enable = true;
            extraPackages = [ pkgs.intel-media-driver ];
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
