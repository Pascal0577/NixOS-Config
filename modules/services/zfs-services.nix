{ config, lib, ... }:
let zfsMaintenance = {
    NoNewPrivileges = true;
    ProtectHostname = true;
    ProtectClock = true;
    ProtectKernelLogs = true;
    ProtectControlGroups = true;
    ProtectHome = true;
    PrivateTmp = true;
    PrivateNetwork = true;
    RestrictSUIDSGID = true;
    RestrictRealtime = true;
    LockPersonality = true;
    SystemCallArchitectures = "native";
    SystemCallFilter = [
        "~@cpu-emulation"
        "~@debug"
        "~@obsolete"
        "~@reboot"
        "~@swap"
        "~@clock"
        "~@module"
    ];
    RestrictAddressFamilies = [ "AF_UNIX" ];
    UMask = "0077";
};
in
{
    config = lib.mkIf config.mySystem.ZFS.enable {
        systemd.services.zfs-zed.serviceConfig = {
            NoNewPrivileges = true;
            ProtectHostname = true;
            ProtectClock = true;
            ProtectKernelLogs = true;
            ProtectHome = true;
            PrivateTmp = true;
            RestrictSUIDSGID = true;
            RestrictRealtime = true;
            LockPersonality = true;
            SystemCallArchitectures = "native";
            SystemCallFilter = [
                "~@cpu-emulation"
                "~@debug"
                "~@obsolete"
                "~@reboot"
                "~@swap"
                "~@clock"
            ];
            RestrictAddressFamilies = [ "AF_UNIX" "AF_NETLINK" ];
            UMask = "0077";
        };

        systemd.services.zfs-scrub.serviceConfig = zfsMaintenance;
        systemd.services.zpool-trim.serviceConfig = zfsMaintenance;
    };
}
