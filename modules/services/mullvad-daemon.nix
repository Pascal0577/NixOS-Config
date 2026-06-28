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
            CapabilityBoundingSet = [
                "CAP_NET_ADMIN"
                "CAP_NET_RAW"
                "CAP_NET_BIND_SERVICE"
                "CAP_DAC_OVERRIDE"
                "CAP_SETUID"
                "CAP_SETGID"
            ];
            RestrictAddressFamilies = [
                "AF_UNIX"
                "AF_INET"
                "AF_INET6"
                "AF_NETLINK"
                "AF_PACKET"  # needed for raw VPN packets
            ];

            ReadWritePaths = [
                /var/log/mullvad-vpn
                /etc/mullvad-vpn
            ];
        };
    };
}
