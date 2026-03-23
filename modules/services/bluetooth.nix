{
    hardware.bluetooth = {
        enable = true;
        settings = {
            General = {
                DiscoverableTimeout = 0;
                PairableTimeout = 0;
                Discoverable = false;
                # FastConnectable = false;
            };
        };
    };

    systemd.services.bluetooth.serviceConfig = {
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
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

        # From earlier
        PrivateTmp = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        NoNewPrivileges = true;
        RestrictAddressFamilies = [ "AF_UNIX" "AF_BLUETOOTH" ];
    };
}
