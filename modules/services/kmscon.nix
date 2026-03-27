{ pkgs, config, lib, ... }:

{
    options.mySystem.applications.kmscon.enable =
        lib.mkEnableOption "KMSCON console module"
        // { default = !config.mySystem.server.enable; };        

    config = lib.mkIf config.mySystem.applications.kmscon.enable {
        services.kmscon = {
            enable = true;
            hwRender = true;
            fonts = [{
                name = "JetBrainsMono Nerd Font";
                package = pkgs.nerd-fonts.jetbrains-mono;
            }];
        };

        systemd.services."kmsconvt@".serviceConfig = {
            ProtectSystem = "full";
            ProtectControlGroups = true;
            ProtectHostname = true;
            ProtectKernelTunables = true;
            ProtectKernelModules = true;
            ProtectKernelLogs = true;
            ProtectClock = true;
            # RestrictSUIDSGID = true;
            RestrictRealtime = true;
            SystemCallErrorNumber = "EPERM";
            SystemCallArchitectures = "native";
            SystemCallFilter = [
                "~@obsolete"
                "~@reboot"
                "~@swap"
                "~@clock"
                "~@cpu-emulation"
            ];
            LockPersonality = true;
        };
    };
}
