{ hostname, ... }:

{
    networking = {
        hostName = hostname;
        networkmanager = {
            enable = true;
            dns = "systemd-resolved";
        };
        modemmanager.enable = false;
        firewall = {
            enable = true;
            trustedInterfaces = [ "virbr0" ];
            allowedTCPPorts = [ 25565 ]; # Minecraft
        };
    };

    services.resolved = {
        enable = true;
        dnssec = "true";
        dnsovertls = "true";
        extraConfig = ''
            DNS=1.1.1.1#cloudflare-dns.com 9.9.9.9#dns.quad9.net
            FallbackDNS=1.0.0.1#cloudflare-dns.com
        '';
    };
}
