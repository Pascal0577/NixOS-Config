{ lib, config, hardening, ... }:

{
    options.mySystem.applications.tuned.enable = lib.mkEnableOption "tuned";
    config = let
        default = hardening.defaultProfile;
    in lib.mkIf config.mySystem.applications.tuned.enable {
        services.tuned.enable = true;

        environment.persistence."/nix/persist" = lib.mkIf config.mySystem.impermanence.enable {
            directories =  [ "/var/log/tuned/" ];
            files = [ "/etc/tuned/ppd_base_profile" ];
        };

        systemd.services.tuned = {
            unitConfig.JoinsNamespaceOf = "tuned-ppd.service";
            serviceConfig = hardening.mkService {
                PrivateDevices = true;

                ProtectControlGroups = false;
                ProtectKernelTunables = false;
                ProtectKernelModules = false;
                SystemCallFilter = default.SystemCallFilter ++ [ "@module" ];
                RestrictAddressFamilies = default.RestrictAddressFamilies ++ [ "AF_NETLINK" ];
                ReadWritePaths = [ /var/log/tuned /etc/tuned ];
            };
        };

        systemd.services.tuned-ppd = {
            unitConfig.JoinsNamespaceOf = "tuned.service";
            serviceConfig = hardening.mkService {
                PrivateDevices = true;

                RestrictAddressFamilies = default.RestrictAddressFamilies ++ [ "AF_NETLINK" ];
                ReadWritePaths = [ /var/log/tuned /etc/tuned ];
            };
        };
    };
}
