{ lib, config, ... }:
let
    common = {
        NoNewPrivileges = true;
        ProtectHome = true;
        ProtectHostname = true;
        ProtectKernelLogs = true;
        ProtectClock = true;
        RestrictSUIDSGID = true;
        RestrictRealtime = true;
        LockPersonality = true;
        MemoryDenyWriteExecute = true;
        SystemCallArchitectures = "native";
        PrivateDevices = true;
        RestrictNamespaces = true;
        PrivateTmp = true;
        IPAddressDeny = [ "0.0.0.0/0" "::/0" ];
        UMask = "0077";
    };
in
{
    config = lib.mkIf config.mySystem.power-management.enable {
        services.tuned.enable = true;
        systemd.services.tuned.serviceConfig = common // {
            SystemCallFilter = [
                "~@cpu-emulation"
                "~@debug"
                "~@keyring"
                "~@mount"
                "~@obsolete"
                "~@reboot"
                "~@swap"
            ];
            RestrictAddressFamilies = [
                "AF_UNIX"
                "AF_NETLINK"
            ];
            CapabilityBoundingSet = [
                "CAP_SYS_ADMIN"
                "CAP_SYS_NICE"
                "CAP_SYS_RAWIO"
                "CAP_DAC_OVERRIDE"
                "CAP_SYS_MODULE"
            ];
        };

        systemd.services.tuned-ppd.serviceConfig = common // {
            ProtectKernelTunables = true;
            ProtectKernelModules = true;
            ProtectControlGroups = true;
            ProtectSystem = "strict";
            ReadWritePaths = [ /var/log/tuned ];
            ProtectProc = "invisible";
            SystemCallFilter = [
                "~@cpu-emulation"
                "~@debug"
                "~@keyring"
                "~@module"
                "~@mount"
                "~@obsolete"
                "~@reboot"
                "~@raw-io"
                "~@swap"
                "~@clock"
            ];
            RestrictAddressFamilies = [ "AF_UNIX" ];
            CapabilityBoundingSet = "";
        };
    };
}
