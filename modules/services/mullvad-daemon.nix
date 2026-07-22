{ pkgs, config, lib, hardening, ... }:

{
    options.mySystem.applications.mullvad.enable =
        lib.mkEnableOption "Mullvad VPN module"
        // { default = !config.mySystem.server.enable; };

    config = lib.mkIf config.mySystem.applications.mullvad.enable {
        services.mullvad-vpn = {
            enable = true;
            package = pkgs.mullvad-vpn;
            enableExcludeWrapper = false;
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

        # systemd needs /var/log/mullvad-vpn and /etc/mullvad-vpn to exist to set up namespaces
        systemd.services.make-mullvad-dirs = {
            enable = true;
            before = [ "mullvad-daemon.service" ];
            wantedBy = [ "mullvad-daemon.service" ];
            description = "Make `mullvad-daemon` state directories";
            serviceConfig = hardening.mkService {
                Type = "oneshot";
                ProtectSystem = false;
                ExecStart = ''${pkgs.coreutils-full}/bin/mkdir -vp \
                    /var/log/mullvad-vpn \
                    /etc/mullvad-vpn \
                    /var/cache/mullvad-vpn
                '';
            };
        };
    };
}
