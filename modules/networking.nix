{ hostname, ... }:

{
    networking = {
        hostName = hostname;
        modemmanager.enable = false;
        useDHCP = true;
        networkmanager = {
            enable = true;
            dns = "systemd-resolved";
        };
        firewall = {
            enable = true;
            trustedInterfaces = [ "virbr0" ];
            allowedTCPPorts = [ 25565 ]; # Minecraft
        };
        nameservers = [
            "1.1.1.1"
            "9.9.9.9"
        ];
    };

    services.resolved = {
        enable = true;
        settings.Resolve = {
            DNSSEC = true;
            DNSOverTLS = true;
        };
    };
}
