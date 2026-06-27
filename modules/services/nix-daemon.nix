{ hardening, ... }:

{
    systemd.services.nix-daemon.serviceConfig = hardening.mkService {
        PrivateDevices = true;
        RestrictAddressFamilies = [ "AF_UNIX" "AF_NETLINK" "AF_INET6" "AF_INET" ];
        UMask = 0077;
    };
}
