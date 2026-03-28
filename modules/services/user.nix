{
    systemd.services."user@".serviceConfig = {
        ProtectSystem = "full";
        ProtectHostname = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectKernelLogs = true;
        ProtectClock = true;
        # RestrictSUIDSGID = true;
        RestrictRealtime = true;
        SystemCallErrorNumber = "EPERM";
        SystemCallArchitectures = "native";
        SystemCallFilter = [
            "~@obsolete"
            "~@reboot"
            "~@swap"
            "~@clock"
            "~@cpu-emulation"
        ];
        LockPersonality = true;
    };
}
