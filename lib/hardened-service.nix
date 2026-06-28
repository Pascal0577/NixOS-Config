{ lib, ... }:

let
    inherit (lib) mkDefault;

    defaultProfile = {
        NoNewPrivileges = true;
        ProtectSystem = "strict";
        ProtectHome = mkDefault true;
        ProtectClock = true;
        ProtectHostname = true;
        ProtectKernelTunables = mkDefault true;
        ProtectKernelModules = mkDefault true;
        ProtectKernelLogs = true;
        ProtectControlGroups = mkDefault "strict";
        ProtectProc = mkDefault "invisible";
        PrivateTmp = mkDefault "disconnected";
        PrivateMounts = true;
        PrivateNetwork = true;
        RestrictNamespaces = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        MemoryDenyWriteExecute = true;
        LockPersonality = true;
        SystemCallArchitectures = "native";
        UMask = mkDefault 0077;
        SystemCallFilter = [
            "~@cpu-emulation"
            "~@obsolete"
            "~@swap"
            "~@clock"
            "~@module"
            "~@debug"
            "~@reboot"
            "~@mount"
            "~@keyring"
        ];
        CapabilityBoundingSet = [
            "~CAP_SET(UID|GID|PCAP)"
            "~AF_(INET|INET6)"
            "~CAP_NET_ADMIN"
        ];
        RestrictAddressFamilies = [
            "AF_UNIX"
            "~AF_(INET|INET6)"
            "~AF_PACKET"
        ];
        IPAddressDeny = [ "any" ];
    };

    enabledNetworking = {
        PrivateNetwork = false;
        IPAddressDeny = [];
        RestrictAddressFamilies = [
            "AF_UNIX"
            "AF_NETLINK"
            "AF_INET"
            "AF_INET6"
            "AF_PACKET"
        ];
        CapabilityBoundingSet = [ "AF_(INET|INET6)" ];
    };
in
{
    inherit defaultProfile;

    mkService = overrides:
        let
            networking = overrides.networking or false;
            rest = removeAttrs overrides [ "networking" ];
        in
        defaultProfile // lib.optionalAttrs networking enabledNetworking // rest;

    mkServiceExtending = overrides: extra:
        let
            merged = defaultProfile // overrides;
            extended = lib.mapAttrs
                (name: items: (merged.${name} or []) ++ items)
                extra;
        in
        merged // extended;
}
