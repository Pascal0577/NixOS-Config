{
    imports = [
        ./applications
        ./boot.nix
        ./locale-time.nix
        ./networking.nix
        ./power-management.nix
        ./users.nix
    ];

    security.rtkit.enable = true;
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "26.05";
    services.openssh.enable = true;

    systemd = {
        # If a service has tried to stop for longer than 10s something has gone wrong
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
