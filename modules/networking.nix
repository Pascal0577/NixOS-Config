{ hostname, ... }:

{
    networking = {
        hostName = hostname;
        networkmanager.enable = true;
        modemmanager.enable = false;
        firewall = {
            enable = true;
            trustedInterfaces = [ "virbr0" ];
            allowedTCPPorts = [ 25565 ]; # Minecraft
        };
    };
}
