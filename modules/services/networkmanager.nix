{ hardening, ... }:

{
    systemd.services.NetworkManager.serviceConfig = hardening.mkService {
        RestrictAddressFamilies = [ 
            "AF_UNIX" 
            "AF_NETLINK"
            "AF_INET"
            "AF_INET6"
            "AF_PACKET"
        ];
        SystemCallFilter = [
            "~@mount"
            "~@module"
            "~@swap"
            "~@obsolete" 
            "~@cpu-emulation" 
            "ptrace"
        ];
    };
}
