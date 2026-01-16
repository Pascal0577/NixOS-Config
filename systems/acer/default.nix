{ pkgs, ... }:
{
    # Declare mathematica module here. I have the sources for it on only one machine
    imports = [
        ./hardware-configuration.nix
        ../../modules/desktop/niri
    ];

    services.xserver.videoDrivers = [ "modesetting" "nvidia" ];
    hardware.nvidia = {
        open = true;
        modesetting.enable = true;
        nvidiaSettings = false;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        prime = {
            sync.enable = true;
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
            "i915.enable_guc=3"
            "i915.enable_fbc=1"
        ];
    };
}
