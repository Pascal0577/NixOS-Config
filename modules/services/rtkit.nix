{ hardening, ... }: {
    security.rtkit.enable = true;
    systemd.services.rtkit-daemon.serviceConfig = hardening.mkService {
        RestrictRealtime = false;
        PrivateDevices = true;
        DevicePolicy = "closed";
        RestrictAddressFamilies = [ 
            "~AF_INET6"  
            "~AF_INET"
            "~AF_PACKET"
        ];
        SystemCallFilter = [
          "~@cpu-emulation"
          "~@obsolete"
          "~@swap"
          "~@clock"
          "~@module"
          "~@debug"
          "~@reboot"
        ];
    };
}
