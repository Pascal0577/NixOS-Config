{ username, lib, ... }:

{
    options.mySystem.server.enable = lib.mkEnableOption ''
        Whether to use system as a server.
        Disable graphical apps, pipewire, etc
    '';

    config = {
        nixpkgs.config.allowUnfree = true;
        system.stateVersion = "26.05";

        nix.settings = {
            experimental-features = [ "nix-command" "flakes" ];
            trusted-users = [ "${username}" ];
        };

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
    };
}
