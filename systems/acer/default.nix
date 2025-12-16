{ pkgs, ... }:
{
    imports = [ ./hardware-configuration.nix ];
    nvidia.enable = true;

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

    hardware.graphics.extraPackages = with pkgs; [
        intel-media-driver 
    ];

    boot = {
        initrd = {
            kernelModules = [ "i915" ];
        };

        kernelParams = [
            "i915.fastboot=1"
            "i915.enable_guc=0"
            "i915.enable_fbc=0"
        ];
    };
}
