{ pkgs, lib, ... }:

{
    environment.systemPackages = [ pkgs.dmenu ];
    services = {
        displayManager.ly.enable = true;
        xserver = {
            enable = lib.mkForce true;
            windowManager.oxwm.enable = true;
        };
    };
}
