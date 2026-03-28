{ lib, config, ... }:
let
    common = {
        NoNewPrivileges = true;
        ProtectHome = true;
        ProtectHostname = true;
        ProtectKernelLogs = true;
        ProtectClock = true;
        PrivateTmp = true;
        PrivateNetwork = true;
        PrivateDevices = true;
        RestrictSUIDSGID = true;
        RestrictRealtime = true;
        RestrictNamespaces = true;
        LockPersonality = true;
        MemoryDenyWriteExecute = true;
        SystemCallArchitectures = "native";
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
                "~@module"
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
            ];
        };

        systemd.services.tuned-ppd.serviceConfig = common // {
            ProtectKernelTunables = true;
            ProtectKernelModules = true;
            ProtectControlGroups = true;
            ProtectSystem = "strict";
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
