{
    systemd.services.systemd-journald.serviceConfig = {
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectControlGroups = true;
        RestrictSUIDSGID = true;
        MemoryDenyWriteExecute = true;
        SystemCallArchitectures = "native";
        NoNewPrivileges = true;
        ProtectProc = "invisible";
        ProtectHostname = true;
        PrivateMounts = true;
    };
}
