{ pkgs, username, ... }:

{
    imports = [
        # ./paperwm.nix
        ./dash-to-dock.nix
    ];

    environment = {
        sessionVariables = { NIXOS_OZONE_WL = "1"; };
        systemPackages = with pkgs; [
            yaru-theme
            icoextract
            dconf-editor
        ];
    };

    services.displayManager.gdm = {
        enable = true;
        wayland = true;
    };

    services.desktopManager.gnome.enable = true;

    environment.gnome.excludePackages = (with pkgs; [
        yelp             epiphany
        atomix           cheese
        epiphany         evince
        geary            gedit 
        gnome-console    gnome-text-editor
        gnome-maps       gnome-clocks 
        gnome-music      simple-scan
        gnome-tour       gnome-photos
        gnome-contacts   gnome-weather
        gnome-calendar   gnome-connections
        snapshot         hitori
        iagno            tali
        loupe
    ]);

    home-manager.users.${username} = {
        dconf = {
            enable = true;
            settings = {
                "org/gnome/shell" = {
                    disable-user-extensions = false;
                    favorite-apps = [
                        "com.mitchellh.ghostty.desktop"
                        "zen-beta.desktop"
                        "vesktop.desktop"
                        "org.gnome.Nautilus.desktop"
                    ];
                };

                "org/gnome/desktop/peripherals/keyboard" = {
                    numlock-state = true;
                };

                "org/gnome/nautilus/preferences" = {
                    click-policy = "single";
                };

                "org/gnome/desktop/wm/keybindings" = {
                    toggle-fullscreen = [
                        "F11"
                    ];
                };

                "org/gnome/desktop/interface" = {
                    show-battery-percentage = true;
                    accent-color = "pink";
                    clock-format = "12h";
                };

                "org/gnome/desktop/sound".theme-name = "Yaru";

                "org/gnome/desktop/wm/preferences" = {
                    resize-with-right-button = true;
                    auto-raise = true;
                    auto-raise-delay = 0;
                    focus-mode = "sloppy";
                };

                "org/gnome/desktop/datetime".automatic-timezone = true;

                "org/gnome/login-screen" = {
                    enable-fingerprint-authentication = false;
                    enable-smartcard-authentication = false;
                };

                "org/gnome/settings-daemon/plugins/media-keys" = {
                    custom-keybindings = [
                        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
                        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/playerctl-forward/"
                        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/playerctl-backward/"
                    ];
                };

                "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
                    name = "Open Terminal";
                    command = "ghostty";
                    binding = "<Super>Return";
                };

                "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/playerctl-forward" = {
                    name = "Go forward in playing media";
                    command = "playerctl position 5+";
                    binding = "<Super>XF86AudioNext";
                };

                "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/playerctl-backward" = {
                    name = "Go backward in playing media";
                    command = "playerctl position 5-";
                    binding = "<Super>XF86AudioPrev";
                };
            };
        };

    };
}
