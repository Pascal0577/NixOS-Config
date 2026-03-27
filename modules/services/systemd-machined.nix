{
    systemd.services.systemd-machined.serviceConfig = {
        NoNewPrivileges = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        ProtectClock = true; 
        ProtectHostname = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectKernelLogs = true;
        ProtectProc = "invisible";
        PrivateTmp = true;
        PrivateMounts = true;
        PrivateUsers = true;
        PrivateNetwork = true;
        RestrictNamespaces = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        RestrictAddressFamilies = [ "AF_UNIX" ];
        MemoryDenyWriteExecute = true;
        SystemCallArchitectures = "native";
    };
}
