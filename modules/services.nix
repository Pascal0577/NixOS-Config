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

        kmscon = {
            enable = true;
            hwRender = true;
            fonts = [{
                name = "JetBrainsMono Nerd Font";
                package = pkgs.nerd-fonts.jetbrains-mono;
            }];
            # package = pkgs.callPackage ../packages/kmscon {};
        };
    };

    systemd.user.extraConfig = ''
        DefaultTimeoutStopSec=10s
    '';

    systemd.services = {
        "serial-getty@".enable = false;
        NetworkManager-wait-online.enable = false;
    };
}
