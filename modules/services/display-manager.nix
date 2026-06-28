{ hardening, lib, ... }:

{
    systemd.services.display-manager.serviceConfig = hardening.mkService {
        ProtectHome = false;
        PrivateIPC = true;
        KeyringMode = lib.mkForce "private";
        CapabilityBoundingSet = [
            "CAP_SYS_ADMIN" 
            "CAP_SETUID"
            "CAP_SETGID"
            "CAP_SETPCAP"
            "CAP_KILL"
            "CAP_SYS_TTY_CONFIG"
            "CAP_DAC_OVERRIDE"
            "CAP_DAC_READ_SEARCH"
            "CAP_FOWNER"
            "CAP_IPC_OWNER" 
            "CAP_FSETID"
            "CAP_SETFCAP"
            "CAP_CHOWN"
            "CAP_SYS_CHROOT"
        ];
    };
}
