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

        CapabilityBoundingSet = [ ];
    };
in
{
    inherit defaultProfile;

    mkService = overrides: defaultProfile // overrides;

    mkServiceExtending = overrides: extra:
        let
            merged = defaultProfile // overrides;
            extended = lib.mapAttrs
                (name: items: (merged.${name} or []) ++ items)
                extra;
        in
        merged // extended;
}
