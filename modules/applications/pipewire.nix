{ config, lib, ... }:

{
    options.mySystem.applications.pipewire.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable my pipewire module";
    };

    config = lib.mkIf config.mySystem.applications.pipewire.enable {
        hardware.bluetooth.enable = true;
        services.pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            jack.enable = true;
        };
    };
}
