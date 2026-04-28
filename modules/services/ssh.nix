{ config, lib, username, pkgs, ... }:

{
    options.mySystem.applications.ssh.enable =
        lib.mkEnableOption "SSH service configuration" // { default = true; };

    config = lib.mkIf config.mySystem.applications.ssh.enable {
        boot.kernelParams = [
            "systemd.show_status=1"   # show service start/fail on console
            "systemd.log_level=info"  # or "debug" for full firehose
            "systemd.log_target=console"  # send logs to the console/serial
            "console=ttyS0"
        ];

        users.users.${username}.openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINcq68JNj92VwwUXhtxLw/yfDStY2dgroWJC3WQIFErx pascal@acer"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG/wHEHpwkF1VwCS/MxZf2cvECIeUHdbiLjO1J1jz0LL pascal@lenovo"
        ];

        services.openssh = {
            enable = true;
            hostKeys = [{
                path = "/etc/ssh/ssh_host_ed25519_key";
                type = "ed25519";
            }];
            settings = {
                PasswordAuthentication = false;
                PermitRootLogin = "no";
                StrictModes = true;
            };
        };

        system.activationScripts.ssh-host-keys = {
            text = ''
                mkdir -p /nix/persist/etc/ssh
                chmod 755 /nix/persist/etc/ssh
                if [ ! -f /nix/persist/etc/ssh/ssh_host_ed25519_key ]; then
                    ${pkgs.openssh}/bin/ssh-keygen \
                        -t ed25519 \
                        -N "" \
                        -f /nix/persist/etc/ssh/ssh_host_ed25519_key
                fi
                chmod 600 /nix/persist/etc/ssh/ssh_host_ed25519_key
                chmod 644 /nix/persist/etc/ssh/ssh_host_ed25519_key.pub
            '';
            deps = [];
        };
        
        systemd.services.sshd.serviceConfig = {
            StandardError = "journal+console";
            ExecStart = lib.mkForce "${pkgs.openssh}/bin/sshd -D -d -e -f /etc/ssh/sshd_config";
        };

        # systemd.services.sshd.serviceConfig = {
        #     NoNewPrivileges = true;
        #     ProtectSystem = "full";
        #     ProtectClock = true; 
        #     ProtectHostname = true;
        #     ProtectKernelTunables = true;
        #     ProtectKernelModules = true;
        #     ProtectKernelLogs = true;
        #     ProtectControlGroups = true; 
        #     ProtectProc = "invisible";
        #     PrivateTmp = true;
        #     PrivateMounts = true;
        #     PrivateDevices = true;
        #     RestrictNamespaces = true;
        #     RestrictRealtime = true;
        #     RestrictSUIDSGID = true;
        #     MemoryDenyWriteExecute = true;
        #     LockPersonality = true;
        #     DevicePolicy = "closed";
        #     SystemCallArchitectures = "native";
        #     SystemCallFilter = [
        #       "~@keyring"
        #       "~@swap"
        #       "~@clock"         
        #       "~@module"
        #       "~@obsolete"
        #       "~@cpu-emulation"
        #       "~@debug"
        #     ];
        #     CapabilityBoundingSet = [
        #         "~CAP_SETUID"
        #         "~CAP_SETGID"
        #         "~CAP_SETPCAP"
        #         "~CAP_SYS_PTRACE"
        #     ];
        # };
    };
}
