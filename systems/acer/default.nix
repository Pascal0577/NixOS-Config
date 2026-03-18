{ pkgs, config, lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ] ++ lib.filesystem.listFilesRecursive ../../modules;

    mySystem = {
        theme.everforest.enable = true;
        desktop.niri.enable = true;
        boot.enableZfs = false;
        applications = {
            helix.enable = true;
            gtk4-apps.enable = true;
            noctalia.enable = true;
            swayidle.enable = false;
            launcher.vicinae.enable = true;
            terminal.foot.enable = true;
            file-manager.yazi.enable = true;
            heroic.enable = false;
        };
    };

    services.displayManager.ly.enable = true;
    networking.hostId = "618f1264";

    environment.systemPackages = with pkgs; [
        playerctl
        losslesscut-bin
        pinta
        lmstudio
        wineWow64Packages.unstableFull
    ];

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
        };
    };

    boot = {
        initrd.kernelModules = [ "i915" ];
        binfmt.emulatedSystems = [ "aarch64-linux" ];
        kernelParams = [
            "i915.enable_guc=3"
            "i915.enable_fbc=1"
        ];
    };
}
