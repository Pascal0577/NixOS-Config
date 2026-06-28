{ hardening, ... }:

{
    systemd.services.NetworkManager.serviceConfig = hardening.mkService {
        networking = true;
        ProtectKernelTunable = false;
        SystemCallFilter = hardening.defaultProfile.SystemCallFilter ++ [ "ptrace" ];
        CapabilityBoundingSet = [ "CAP_NET_ADMIN CAP_NET_RAW" ];
    };
}
