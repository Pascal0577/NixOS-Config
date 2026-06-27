{ hardening, ... }:  {
    systemd.services.acpid.serviceConfig = hardening.mkService {
        PrivateNetwork = true;
    };
}
