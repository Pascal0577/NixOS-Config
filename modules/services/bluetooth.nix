{ config, lib, hardening, ... }:

{
    hardware.bluetooth = {
        enable = lib.mkDefault (!config.mySystem.server.enable);
        settings = {
            General = {
                DiscoverableTimeout = 0;
                PairableTimeout = 0;
                Discoverable = false;
            };
        };
    };

    systemd.services.bluetooth.serviceConfig = hardening.mkService {
        RestrictAddressFamilies = [ "AF_UNIX" "AF_BLUETOOTH" ];
    };
}
