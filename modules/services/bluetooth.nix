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
        PrivateNetwork = false;
        RestrictAddressFamilies = default.RestrictAddressFamilies ++ [ "AF_BLUETOOTH" ];
    };
}
