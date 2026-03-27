{
    systemd.services.nvidia-powerd.serviceConfig = {
        NoNewPrivileges = true;
        ProtectHome = true;
        ProtectHostname = true;
        ProtectKernelLogs = true;
        ProtectClock = true;
        ProtectControlGroups = true;
        PrivateTmp = true;
        PrivateNetwork = true;
        ProtectProc = "invisible";
        ProtectSystem = "strict";
        RestrictSUIDSGID = true;
        RestrictRealtime = true;
        RestrictNamespaces = true;
        LockPersonality = true;
        SystemCallArchitectures = "native";
        SystemCallFilter = [
            "~@clock"
            "~@cpu-emulation"
            "~@debug"
            "~@module"
            "~@obsolete"
            "~@reboot"
            "~@swap"
        ];
        RestrictAddressFamilies = [
            "AF_UNIX"
            "AF_NETLINK"
        ];
        CapabilityBoundingSet = [
            "~CAP_SETUID"
            "~CAP_SETGID"
            "~CAP_SETPCAP"
        ];
        UMask = "0077";
    };
}
