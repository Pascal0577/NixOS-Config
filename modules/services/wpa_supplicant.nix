{ hardening, ... }:

{
    systemd.services.wpa_supplicant.serviceConfig = hardening.mkService {
        networking = true;
        SystemCallFilter = hardening.defaultProfile.SystemCallFilter ++ [
            "~@raw-io"
            "~@privileged"
            "~@resources" 
            "ptrace"
        ];
        CapabilityBoundingSet = [ "CAP_NET_ADMIN CAP_NET_RAW" ];
    };
}
