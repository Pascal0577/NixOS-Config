{ pkgs, config, lib, hardening, ... }:

{
    options.mySystem.applications.mullvad.enable =
        lib.mkEnableOption "Mullvad VPN module"
        // { default = !config.mySystem.server.enable; };

    config = lib.mkIf config.mySystem.applications.mullvad.enable {
        services.mullvad-vpn = {
            enable = true;
            package = pkgs.mullvad-vpn;
        };

        environment.persistence."/nix/persist".directories =
            lib.mkIf config.mySystem.impermanence.enable [ "/etc/mullvad-vpn" ];

        systemd.services.mullvad-daemon.serviceConfig = hardening.mkService {
            networking = true;
            CapabilityBoundingSet = [
                "CAP_NET_ADMIN"
                "CAP_NET_RAW"
                "CAP_NET_BIND_SERVICE"
                "CAP_DAC_OVERRIDE"
                "CAP_SETUID"
                "CAP_SETGID"
            ];

            ReadWritePaths = [
                /var/log/mullvad-vpn
                /etc/mullvad-vpn
            ];
        };
    };
}
