{
    security.rtkit.enable = true;
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "26.05";

    systemd = {
        # If a service has tried to stop for longer than 10s 
        # something has gone wrong and it should be force stopped
        user.extraConfig = "DefaultTimeoutStopSec=10s";
        settings.Manager = {
            DefaultTimeoutStopSec = "10s";
        };

        services = {
            "serial-getty@".enable = false;
            NetworkManager-wait-online.enable = false;
        };
    };
}
