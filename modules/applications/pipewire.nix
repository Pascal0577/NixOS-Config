{ config, lib, ... }:

{
    options.mySystem.applications.pipewire.enable =
        lib.mkEnableOption "Pipewire module"
        // { default = !config.mySystem.server.enable; };

    config = lib.mkIf config.mySystem.applications.pipewire.enable {
        services.pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            jack.enable = true;
        };
    };
}
