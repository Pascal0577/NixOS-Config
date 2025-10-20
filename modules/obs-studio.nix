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
                }
            );
        };
    };
}
