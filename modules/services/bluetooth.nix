{
    hardware.bluetooth = {
        enable = true;
        settings = {
            General = {
                DiscoverableTimeout = 0;
                PairableTimeout = 0;
                Discoverable = false;
            };
        };
    };

    systemd.services.bluetooth.serviceConfig = {
        ProtectKernelLogs = true;
        ProtectHostname = true;
        ProtectControlGroups = true;
        ProtectProc = "invisible";
        SystemCallFilter = [
            "~@obsolete"
            "~@cpu-emulation"
            "~@swap"
            "~@reboot"
            "~@mount"
        ];
        SystemCallArchitectures = "native";

        PrivateTmp = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        NoNewPrivileges = true;
        RestrictAddressFamilies = [ "AF_UNIX" "AF_BLUETOOTH" ];
    };
}
