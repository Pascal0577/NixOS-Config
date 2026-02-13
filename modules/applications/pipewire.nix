{ config, lib, ... }:

{
    options.applications.pipewire.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable my pipewire module";
    };

    config = lib.mkIf config.applications.pipewire.enable {
        services.pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            jack.enable = true;
        };
    };
}
