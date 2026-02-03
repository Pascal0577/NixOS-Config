{
    imports = [
        ./kmscon.nix
        ./mullvad-vpn.nix
        ./pipewire.nix
        ./xserver.nix
    ];

    services = {
        openssh.enable = true;
        printing.enable = true;
    };

    systemd.user.extraConfig = ''
        DefaultTimeoutStopSec=10s
    '';

    systemd.services = {
        "serial-getty@".enable = false;
        NetworkManager-wait-online.enable = false;
    };
}
