{ pkgs, config, lib, ... }:

{
    options.mySystem.applications.mullvad.enable =
        lib.mkEnableOption "Mullvad VPN module" // { default = true; };

    config = lib.mkIf config.mySystem.applications.mullvad.enable {
        services.mullvad-vpn = {
            enable = true;
            package = pkgs.mullvad-vpn;
        };

        systemd.services.mullvad-daemon.serviceConfig = {
            NoNewPrivileges = true;
            ProtectHome = true;
            ProtectHostname = true;
            ProtectKernelLogs = true;
            ProtectKernelModules = true;
            ProtectControlGroups = true;
            ProtectClock = true;
            PrivateTmp = true;
            RestrictSUIDSGID = true;
            RestrictRealtime = true;
            LockPersonality = true;
            SystemCallArchitectures = "native";
            SystemCallFilter = [
                "~@clock"
                "~@cpu-emulation"
                "~@debug"
                "~@module"
                "~@obsolete"
                "~@reboot"
                "~@swap"
            ];
            CapabilityBoundingSet = [
                "CAP_NET_ADMIN"
                "CAP_NET_RAW"
                "CAP_NET_BIND_SERVICE"
                "CAP_DAC_OVERRIDE"
                "CAP_SETUID"
                "CAP_SETGID"
            ];
            UMask = "0077";
            RestrictAddressFamilies = [
                "AF_UNIX"
                "AF_INET"
                "AF_INET6"
                "AF_NETLINK"
                "AF_PACKET"  # needed for raw VPN packets
            ];
            RestrictNamespaces = [
                "~user"
                "~pid"
                "~uts"
                "~ipc"
                "~cgroup"
            ];
        };
    };
}
