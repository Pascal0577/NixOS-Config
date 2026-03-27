{
    systemd.services.systemd-rfkill.serviceConfig = {
        NoNewPrivileges = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        ProtectKernelLogs = true;
        ProtectControlGroups = true;
        ProtectClock = true; 
        ProtectHostname = true;
        ProtectProc = "invisible";
        PrivateTmp = true;
        PrivateNetwork = true;
        PrivateUsers = true;
        RestrictNamespaces = true;
        RestrictRealtime = true;
        RestrictAddressFamilies = [ "AF_UNIX" ];
        RestrictSUIDSGID = true;
        MemoryDenyWriteExecute = true;
        SystemCallFilter = [
            "~@swap"
            "~@obsolete"
            "~@cpu-emulation"
            "~@privileged"
        ];
        SystemCallArchitectures = "native";
        LockPersonality = true;
        CapabilityBoundingSet = [
            "~CAP_SYS_PTRACE" 
            "~CAP_SYS_PACCT"
        ];
    };
}
