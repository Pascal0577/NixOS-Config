{ hardening, ... }:

{
    systemd.services.systemd-rfkill.serviceConfig = hardening.mkService {
        CapabilityBoundingSet = [
            "~CAP_SYS_PTRACE" 
            "~CAP_SYS_PACCT"
        ];
    };
}
