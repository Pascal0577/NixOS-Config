{ config, lib, username, pkgs, ... }:

{
    options.mySystem.applications.ssh.enable =
        lib.mkEnableOption "SSH service configuration" // { default = true; };

    config = lib.mkIf config.mySystem.applications.ssh.enable {
        users.users.${username}.openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINcq68JNj92VwwUXhtxLw/yfDStY2dgroWJC3WQIFErx pascal@acer"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG/wHEHpwkF1VwCS/MxZf2cvECIeUHdbiLjO1J1jz0LL pascal@lenovo"
        ];

        services.openssh = {
            enable = true;
            settings = {
                PasswordAuthentication = false;
                PermitRootLogin = "no";
                StrictModes = true;
            };
        };

        environment.persistence."/nix/persist".directories =
            lib.mkIf config.mySystem.impermanence.enable [
                "/etc/ssh"
                {
                    directory = "/home/${username}/.ssh";
                    mode = "u=rwx,g=rx,o=";
                    user = "${username}";
                    group = "users";
                }
            ];
        
        systemd.services.sshd.serviceConfig = {
            StandardError = "journal+console";
            ExecStart = lib.mkForce "${pkgs.openssh}/bin/sshd -D -e -f /etc/ssh/sshd_config";
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
            SystemCallArchitectures = "native";
            SystemCallFilter = [
              "~@keyring"
              "~@swap"
              "~@clock"
              "~@module"
              "~@obsolete"
              "~@cpu-emulation"
              "~@debug"
            ];
            CapabilityBoundingSet = [
                "~CAP_SETPCAP"
                "~CAP_SYS_PTRACE"
            ];
        };
    };
}
