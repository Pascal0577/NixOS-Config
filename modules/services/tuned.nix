{ lib, config, hardening, ... }:

{
    options.mySystem.applications.tuned.enable = lib.mkEnableOption "tuned";
    config = lib.mkIf config.mySystem.applications.tuned.enable {
        services.tuned.enable = true;

        environment.persistence."/nix/persist" = lib.mkIf config.mySystem.impermanence.enable {
            directories =  [ "/var/log/tuned/" ];
            files = [ "/etc/tuned/ppd_base_profile" ];
        };

        systemd.services.tuned.serviceConfig = hardening.mkService {
            PrivateDevices = true;
            PrivateNetwork = true;
            RestrictAddressFamilies = [ "AF_UNIX" "AF_NETLINK" ];

            ProtectKernelTunables = false;
            ProtectKernelModules = false;
            SystemCallFilter = hardening.defaultProfile.SystemCallFilter ++ [ "@module" ];
            ProtectProc = "default";
            ReadWritePaths = [ /var/log/tuned /etc/tuned ];
        };

        systemd.services.tuned-ppd.serviceConfig = hardening.mkService {
            PrivateDevices = true;
            PrivateNetwork = true;

            ProtectProc = "default";
            ReadWritePaths = [ /var/log/tuned /etc/tuned ];
        };
    };
}
