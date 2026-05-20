{ lib, config, ... }:

{
    services.xserver.videoDrivers = [ "modesetting" "nvidia" ];
    hardware.nvidia = {
        open = true;
        modesetting.enable = true;
        nvidiaSettings = false;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        dynamicBoost.enable = true;
        prime = {
            sync.enable = true;
            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:1:0:0";
        };
    };

    environment.persistence."/nix/persist".directories =
        lib.mkIf config.mySystem.impermanence.enable [ "/var/log/nvtopps/" ];
        
}
