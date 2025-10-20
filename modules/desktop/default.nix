{ pkgs, username, ... }:

{
    imports = [
        ./vicinae.nix
        ./gnome.nix
        ./niri.nix
        ./noctalia.nix
        ./zen-browser.nix
        ./kde.nix
    ];

    environment.systemPackages = with pkgs; [
        playerctl
        losslesscut-bin
        pinta
        qbittorrent
    ];

    fonts = {
        fontconfig = {
            enable = true;
            useEmbeddedBitmaps = true;
        };

        packages = with pkgs; [
            ubuntu-sans
            ubuntu-sans-mono
            noto-fonts-cjk-sans
            noto-fonts-emoji
            akkadian
        ];
    };

    environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
    };

    services = {
        printing.enable = true;
        openssh.enable = true;

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

    home-manager.users.${username} = {
        home.pointerCursor = {
            package = pkgs.yaru-theme;
            name = "Yaru";
            size = 24;
        };

        gtk = {
            enable = true;
            cursorTheme = {
                size = 24;
                package = pkgs.yaru-theme;
                name = "Yaru";
            };
        };
    };
}
