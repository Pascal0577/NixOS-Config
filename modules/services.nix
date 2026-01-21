{ pkgs, ... }:

{
    services = {
        openssh.enable = true;
        printing.enable = true;

        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            jack.enable = true;
        };

        xserver = {
            enable = false;
            excludePackages = [ pkgs.xterm ];
            xkb = {
              layout = "us";
              variant = "";
            };
        };

        mullvad-vpn = {
            enable = true;
            package = pkgs.mullvad-vpn;
        };
    };

    systemd.user.extraConfig = ''
        DefaultTimeoutStopSec=10s
    '';

    systemd.services."serial-getty@ttyS0".enable = false;
    systemd.services."serial-getty@ttyS1".enable = false;
    systemd.services."serial-getty@ttyS2".enable = false;
    systemd.services."serial-getty@ttyS3".enable = false;
    systemd.services.NetworkManager-wait-online.enable = false;
}
