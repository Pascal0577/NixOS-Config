{
    # Disable USB auto-suspend so my mouse doesn't get fucked up
    boot.kernelParams = [ "usbcore.autosuspend=-1" ];

    powerManagement = {
        enable = true;
        powertop.enable = true;
    };

    services.tuned.enable = true;
}
