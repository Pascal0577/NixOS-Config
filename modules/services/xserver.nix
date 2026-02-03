{ pkgs, ... }:

{
    services.xserver = {
        enable = false;
        excludePackages = [ pkgs.xterm ];
        xkb = {
            layout = "us";
            variant = "";
        };
    };
}
