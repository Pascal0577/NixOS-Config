{ config, lib, pkgs, ... }:

{
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

        hardware.graphics.extraPackages = with pkgs; [
            intel-media-driver 
            intel-vaapi-driver 
            libvdpau-va-gl
        ];

        boot = {
            initrd = {
                kernelModules = [ "i915" ];
            };

            kernelParams = [
                "i915.fastboot=1"
                "i915.enable_guc=3"
                "i915.enable_fbc=3"
            ];
        };
    };
}
