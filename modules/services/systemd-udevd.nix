{
    systemd.services.systemd-udevd.serviceConfig = {
        NoNewPrivileges = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        ProtectKernelLogs = true;
        ProtectControlGroups = true;
        ProtectClock = true; 
        ProtectProc = "invisible";
        RestrictNamespaces = true;
        CapabilityBoundingSet = "~CAP_SYS_PTRACE ~CAP_SYS_PACCT";
    };
}
