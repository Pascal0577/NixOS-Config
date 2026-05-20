{ hostname, lib, config, ... }:

{
    networking = {
        hostName = hostname;
        firewall.enable = true;
        modemmanager.enable = false;
        networkmanager = {
            enable = true;
            dns = "systemd-resolved";
        };
    };

    services.resolved = {
        enable = true;
        settings.Resolve = {
            DNS = "9.9.9.9#dns.quad9.net";
            FallbackDNS = "1.1.1.1#cloudflare-dns.com 8.8.8.8#dns.google";
            DNSSEC = true;
            DNSOverTLS = true;
        };
    };

    environment.persistence."/nix/persist".directories =
        lib.mkIf config.mySystem.impermanence.enable [
            "/var/lib/bluetooth"
            "/etc/NetworkManager/system-connections"
        ];
}
