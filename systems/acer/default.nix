{ pkgs, lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./impermanence.nix
    ] ++ lib.filesystem.listFilesRecursive ../../modules;

    mySystem = {
        theme.everforest.enable = true;
        impermanence.enable = true;
        boot.enableZfs = true;
        desktop.niri = {
            enable = true;
            unstable = true;
        };
        applications = {
            obs.enable = false;
            helix.enable = true;
            gtk-apps.enable = true;
            noctalia.enable = true;
            swayidle.enable = false;
            launcher.vicinae.enable = true;
            terminal.foot.enable = true;
            file-manager.yazi.enable = true;
        };
    };

    environment.systemPackages = with pkgs; [
        playerctl
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
}
