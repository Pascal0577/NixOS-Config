{ hardening, ... }: {
    systemd.services.nscd.serviceConfig = hardening.mkService {};
}
