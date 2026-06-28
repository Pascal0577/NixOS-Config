{ hardening, ... }:

{
    systemd.services.NetworkManager-dispatcher.serviceConfig = hardening.mkService {
        RestrictAddressFamilies = [ 
            "AF_UNIX" 
            "AF_NETLINK"
            "AF_INET"
            "AF_INET6"
            "AF_PACKET"
        ];
        SystemCallFilter = hardening.defaultProfile.SystemCallFilter ++ [ "ptrace" ];
        CapabilityBoundingSet = [ "CAP_NET_ADMIN CAP_NET_RAW" ];
    };
}
