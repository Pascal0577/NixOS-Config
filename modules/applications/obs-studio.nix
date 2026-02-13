{ pkgs, config, lib, ... }:

{
    options.applications.obs.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable my OBS Studio module";
    };

    config = lib.mkIf config.applications.obs.enable {
        programs.obs-studio = {
            enable = true;
            plugins = with pkgs.obs-studio-plugins; [
                obs-pipewire-audio-capture
                obs-vaapi
            ];
        };
    };
}
