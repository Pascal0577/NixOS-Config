{ hardening, ... }:

{
    systemd.services.nvidia-powerd.serviceConfig = hardening.mkService {
        PrivateNetwork = true;
        RestrictAddressFamilies = [ "AF_UNIX" "AF_NETLINK" ];

        ProtectKernelTunables = false;
        ProtectKernelModules = false;
        SystemCallFilter = hardening.defaultProfile.SystemCallFilter ++ [ "@module" ];
    };
}
