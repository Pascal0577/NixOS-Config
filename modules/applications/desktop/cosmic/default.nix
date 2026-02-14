{ config, lib, ... }:

{
    options.desktop.cosmic.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable my COSMIC module";
    };

    config = lib.mkIf config.desktop.cosmic.enable {
        services.displayManager.cosmic-greeter.enable = true;
        services.system76-scheduler.enable = true;
        services.desktopManager.cosmic = {
            enable = true;
            xwayland.enable = true;
        };
    };
}
