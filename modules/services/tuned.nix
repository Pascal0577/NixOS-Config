{ lib, config, hardening, ... }:

{
    options.mySystem.applications.tuned.enable = lib.mkEnableOption "tuned";
    config = lib.mkIf config.mySystem.applications.tuned.enable {
        services.tuned.enable = true;
        systemd.services.tuned.serviceConfig = hardening.mkService {
            ProtectKernelTunables = false;
            ProtectKernelModules = false;
            PrivateNetwork = true;
            ReadWritePaths = [ /var/log/tuned ];
            UMask = "0077";
            CapabilityBoundingSet = [
                "CAP_SYS_ADMIN"
                "CAP_SYS_NICE"
                "CAP_SYS_RAWIO"
                "CAP_DAC_OVERRIDE"
                "CAP_SYS_MODULE"
            ];
            SystemCallFilter = [ "~@cpu-emulation" ];
            RestrictAddressFamilies = [ "AF_UNIX" "AF_NETLINK" ];
        };

        systemd.services.tuned-ppd.serviceConfig = hardening.mkService {
            ProtectProc = "default";
            PrivateNetwork = true;
            ReadWritePaths = [ /var/log/tuned ];
            UMask = "0077";
            SystemCallFilter = [
                "~@cpu-emulation"
                "~@debug"
                "~@keyring"
                "~@module"
                "~@mount"
                "~@obsolete"
                "~@reboot"
                "~@raw-io"
                "~@swap"
                "~@clock"
            ];
            RestrictAddressFamilies = [ "AF_UNIX" ];
        };
    };
}
