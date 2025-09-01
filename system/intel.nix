{ pkgs, ... }:

{
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
      # "i915.fastboot=1"
      "i915.enable_guc=3"
      "i915.enable_fbc=3"
    ];
  };
}
