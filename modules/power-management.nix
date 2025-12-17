{ inputs, username, ... }:

{
    # Disable USB auto-suspend so my mouse doesn't get fucked up
    boot.kernelParams = [ "usbcore.autosuspend=-1" ];

    powerManagement = {
        enable = true;
        powertop.enable = true;
    };

    services = {
        tuned.enable = true;
        system76-scheduler = {
            enable = true;
            assignments = {
                desktop-environment = {
                    matchers = [ "niri" "gnome" ];
                };
            };
        };
    };

    home-manager.users.${username} = {
        imports = [
            inputs.system76-scheduler-niri.homeModules.system76-scheduler-niri
        ];
        services.system76-scheduler-niri.enable = true;
    };
}
