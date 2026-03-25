{ config, lib, username, ... }:

{
    options.mySystem.applications.ssh.enable =
        lib.mkEnableOption "SSH service configuration" // { default = true; };

    config = lib.mkIf config.mySystem.applications.ssh.enable {
        users.users.${username}.openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINcq68JNj92VwwUXhtxLw/yfDStY2dgroWJC3WQIFErx pascal@acer"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG/wHEHpwkF1VwCS/MxZf2cvECIeUHdbiLjO1J1jz0LL pascal@lenovo"
        ];

        services.avahi = {
            enable = true;
            nssmdns4 = true;
            openFirewall = true;
            publish = {
                enable = true;
                addresses = true;
                domain = true;
            };
        };

        services.openssh = {
            enable = true;
            settings = {
                PasswordAuthentication = false;
                PermitRootLogin = "no";
                StrictModes = true;
            };
        };

        systemd.services.sshd.serviceConfig = {
            NoNewPrivileges = true;
            ProtectSystem = "full";
            ProtectClock = true; 
            ProtectHostname = true;
            ProtectKernelTunables = true;
            ProtectKernelModules = true;
            ProtectKernelLogs = true;
            ProtectControlGroups = true; 
            ProtectProc = "invisible";
            PrivateTmp = true;
            PrivateMounts = true;
            PrivateDevices = true;
            RestrictNamespaces = true;
            RestrictRealtime = true;
            RestrictSUIDSGID = true;
            MemoryDenyWriteExecute = true;
            LockPersonality = true;
            DevicePolicy = "closed";
            SystemCallFilter = [
              "~@keyring"
              "~@swap"
              "~@clock"         
              "~@module"
              "~@obsolete"
              "~@cpu-emulation"
            ];
            SystemCallArchitectures = "native";
        };
    };
}
