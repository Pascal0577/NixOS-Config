{ pkgs, ... }:

{
    programs.obs-studio = {
        enable = true;

        plugins = with pkgs.obs-studio-plugins; [
            obs-backgroundremoval
            obs-pipewire-audio-capture
            obs-vaapi
            obs-gstreamer
            obs-vkcapture
        ];

        package = (
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
    };
}
