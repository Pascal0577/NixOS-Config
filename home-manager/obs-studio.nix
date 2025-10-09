{ pkgs, ... }:

{
    programs.obs-studio = {
        enable = true;

        # Nvidia hardware acceleration
        package = (
            pkgs.obs-studio.override {
                cudaSupport = true;
            }
        );

        plugins = with pkgs.obs-studio-plugins; [
            obs-backgroundremoval
            obs-pipewire-audio-capture
            obs-vaapi
        ];
    };
}
