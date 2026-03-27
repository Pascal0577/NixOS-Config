{
    systemd.services.nvidia-powerd.serviceConfig = {
        NoNewPrivileges = true;
        ProtectHome = true;
        ProtectHostname = true;
        ProtectKernelLogs = true;
        ProtectClock = true;
        ProtectControlGroups = true;
        PrivateTmp = true;
        RestrictSUIDSGID = true;
        RestrictRealtime = true;
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
        UMask = "0077";
    };
}
