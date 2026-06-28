{ hardening, ... }:

{
    systemd.services.NetworkManager-dispatcher.serviceConfig = hardening.mkService {
        networking = true;
        SystemCallFilter = hardening.defaultProfile.SystemCallFilter ++ [ "ptrace" ];
        CapabilityBoundingSet = [ "CAP_NET_ADMIN CAP_NET_RAW" ];
    };
}
