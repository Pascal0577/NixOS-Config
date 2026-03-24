{ pkgs, config, lib, ... }:

{
    options.mySystem.applications.obs = {
        enable = lib.mkEnableOption "OBS Studio module"
            // { default = !config.mySystem.server.enable; };

        nvidia = lib.mkEnableOption "Enable Nvidia support for OBS";
    };

    config = lib.mkIf config.mySystem.applications.obs.enable {
        programs.obs-studio = {
            enable = true;
            plugins = with pkgs.obs-studio-plugins; [
                obs-pipewire-audio-capture
                obs-vaapi
            ];
            package = lib.mkIf config.mySystem.applications.obs.nvidia (
                pkgs.obs-studio.override {
                    cudaSupport = true;
                    # If we're compiling from source we
                    # might as well apply optimizations
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
        };
    };
}
