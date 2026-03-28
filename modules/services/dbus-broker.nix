{
    services.dbus.implementation = "broker";
    systemd.services.dbus-broker.serviceConfig = {
        NoNewPrivileges = true;
        ProtectClock = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        ProtectControlGroups = true;
        ProtectHostname = true;
        ProtectProc = "invisible";
        RestrictNamespaces = true;
        RestrictSUIDSGID = true;
        RestrictRealtime = true;
        LockPersonality = true;
        MemoryDenyWriteExecute = true;
        SystemCallArchitectures = "native";
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
        RestrictAddressFamilies = [
            "AF_UNIX"
            "AF_NETLINK"
        ];
        CapabilityBoundingSet = [
            "CAP_SETUID"
            "CAP_SETGID"
            "CAP_SETPCAP"
            "CAP_AUDIT_WRITE"
            "CAP_DAC_OVERRIDE"
        ];
        IPAddressDeny = [ "0.0.0.0/0" "::/0" ];
        UMask = "0077";
    };
}
