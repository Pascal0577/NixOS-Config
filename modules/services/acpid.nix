{ hardening, ... }:  {
    systemd.services.acpid.serviceConfig = hardening.mkService {};
}
