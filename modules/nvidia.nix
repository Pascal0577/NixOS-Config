{ config, lib, ... }:

{
    options.mySystem.nvidia.enable = lib.mkEnableOption "Nvidia + Intel laptop";

    config = lib.mkIf config.mySystem.nvidia.enable {
        services.xserver.videoDrivers = [ "modesetting" "nvidia" ];
        hardware.nvidia = {
            open = true;
            nvidiaSettings = false;
            powerManagement.enable = false;
            powerManagement.finegrained = false;
            prime = {
                offload.enable = true;
                offload.enableOffloadCmd = true;
                intelBusId = "PCI:0:2:0";
                nvidiaBusId = "PCI:1:0:0";
            };
        };
    };
}
