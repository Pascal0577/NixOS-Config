{ hardening, ... }: {
    systemd.services.nscd.serviceConfig = hardening.mkService {
        PrivateNetwork = true;
        PrivateDevices = true;
    };
}
