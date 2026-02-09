{ pkgs, lib, ... }:

{
    environment.systemPackages = [ pkgs.dmenu ];
    services.xserver = {
        enable = lib.mkForce true;
        windowManager.oxwm.enable = true;
    };
}
