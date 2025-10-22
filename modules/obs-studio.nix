{ pkgs, lib, config, username, ... }:

{
    home-manager.users.${username} = {
        programs.obs-studio = {
            enable = true;

            plugins = with pkgs.obs-studio-plugins; [
                obs-backgroundremoval
                obs-pipewire-audio-capture
                obs-vaapi
            ];

            # Nvidia hardware acceleration
            package = lib.mkIf config.mySystem.nvidia.enable (
                pkgs.obs-studio.override {
                    cudaSupport = true;
                    # If we're compiling from source we might as well apply optimizations
                    stdenv = lib.mkIf config.mySystem.obs-optimization.enable pkgs.stdenvAdapters.withCFlags [
                        "-O3"
                        "-march=native"
                        "-mtune=native"
                        "-fomit-frame-pointer"
                        "-flto"
                    ] pkgs.stdenv;
                }
            );
        };
    };
}
