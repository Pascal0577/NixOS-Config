{ hardening, ... }: {
    security.rtkit.enable = true;
    systemd.services.rtkit-daemon.serviceConfig = hardening.mkService {
        RestrictRealtime = false;
        PrivateDevices = true;
        SystemCallFilter = hardening.defaultProfile.SystemCallFilter ++ [
            "chroot"
            "setgroups"
            "@resources"
        ];
    };
}
