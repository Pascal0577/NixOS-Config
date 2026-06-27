{ hardening, ... }:

{
    services.dbus.implementation = "broker";
    systemd.services.dbus-broker.serviceConfig = hardening.mkService {
        PrivateNetwork = true;
        RestrictAddressFamilies = [ "AF_UNIX" "AF_NETLINK" ];
        SystemCallFilter = [
            "~@clock"
            "~@cpu-emulation"
            "~@debug"
            "~@module"
            "~@mount"
            "~@obsolete"
            "~@raw-io"
            "~@reboot"
            "~@resources"
            "~@swap"
        ];
        CapabilityBoundingSet = [
            "CAP_SETUID"
            "CAP_SETGID"
            "CAP_SETPCAP"
            "CAP_AUDIT_WRITE"
            "CAP_DAC_OVERRIDE"
        ];
    };
}
