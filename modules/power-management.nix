{ lib, config, ... }:

{
    options.mySystem.power-management.enable =
        lib.mkEnableOption "Power Management settings"
        // { default = !config.mySystem.server.enable; };

    config = lib.mkIf config.mySystem.power-management.enable {
        # Disable USB auto-suspend so my mouse doesn't get fucked up
        boot.kernelParams = [ "usbcore.autosuspend=-1" ];

        powerManagement = {
            enable = true;
            powertop.enable = true;
        };
    };
}
