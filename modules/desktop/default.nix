{ pkgs, ... }:

{
    environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
    };

    services = {
        printing.enable = true;

        xserver = {
            enable = false;
            excludePackages = [ pkgs.xterm ];
            xkb = {
              layout = "us";
              variant = "";
            };
        };

        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            jack.enable = true;
        };

        mullvad-vpn = {
            enable = true;
            package = pkgs.mullvad-vpn;
        };
    };

    hardware = {
        bluetooth.enable = true;
        graphics.enable = true;
    };
}
