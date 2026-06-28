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

    systemd.services.bluetooth.serviceConfig = let
        default = hardening.defaultProfile;
    in hardening.mkService {
        networking = true;
        RestrictAddressFamilies = default.RestrictAddressFamilies ++ [ "AF_BLUETOOTH" ];
        CapabilityBoundingSet = default.CapabilityBoundingSet ++ [
            "CAP_NET_ADMIN"
            "CAP_NET_RAW"
            "CAP_NET_BIND_SERVICE"
            "CAP_DAC_OVERRIDE"
            "CAP_SETUID"
            "CAP_SETGID"
        ];
    };
}
