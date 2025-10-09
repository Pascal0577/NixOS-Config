{ pkgs, ... }:

{
    home.packages = with pkgs; [
        # gnomeExtensions.blur-my-shell
        # gnomeExtensions.clipboard-history
        # gnomeExtensions.dash-to-dock
        gnomeExtensions.user-themes
        gnomeExtensions.paperwm
        celluloid
        dconf-editor
        icoextract
    ];

    home.pointerCursor = {
        package = pkgs.yaru-theme;
        name = "Yaru";
        size = 32;
    };

    gtk = {
        enable = true;
        cursorTheme = {
            size = 24;
            package = pkgs.yaru-theme;
            name = "Yaru";
        };
    };

    dconf = {
        enable = true;
        settings = {
            "org/gnome/shell" = {
                disable-user-extensions = false;
                enabled-extensions = with pkgs.gnomeExtensions; [
                    # blur-my-shell.extensionUuid
                    # clipboard-history.extensionUuid
                    user-themes.extensionUuid
                    paperwm.extensionUuid
                ];
                favorite-apps = [
                    # .desktop files can be found in "/run/current-system/sw/share/applications/"
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

            "org/gnome/mutter" = {
                experimental-features = [
                    "variable-refresh-rate"
                ];
                overlay-key = "";
            };

            "org/gnome/shell/extensions/user-theme".name = "Yaru-dark";

            "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
                static-blur = false;
                blur = false;
            };

            "org/gnome/desktop/wm/keybindings" = {
                toggle-fullscreen = [
                    "F11"
                ];
            };

            "org/gnome/shell/extensions/paperwm" = {
                animation-time = 0.2;
                default-focus-mode = 0; # Edge, vs center or default
                disable-topbar-styling = true;
                edge-preview-enable = true;
                edge-preview-scale = 0.25;
                edge-preview-timeout = 0;
                edge-preview-timeout-enable = true;
                horizontal-margin = 10;
                vertical-margin = 10;
                vertical-margin-bottom = 10;
                window-gap = 10;
                use-default-background = true;
                show-workspace-indicator = false;
                show-window-position-bar = false;
                show-open-position-icon = true;
                show-focus-mode-icon = true;
                selection-border-size = 5;
                selection-border-radius-top = 10;
                selection-border-radius-bottom = 10;
            };

            "org/gnome/shell/extensions/paperwm/keybindings" = {
                close-window = ["<Super>q"];
                move-left = [
                    "<Shift><Super>Left"
                    "<Shift><Super>a"
                ];
                move-right = [
                    "<Shift><Super>Right"
                    "<Shift><Super>d"
                ];
                move-up = [
                    "<Control><Super>Up"
                    "<Control><Super>w"
                ];
                move-down = [
                    "<Control><Super>Down"
                    "<Control><Super>s"
                ];
                switch-left = [
                    "<Super>Left"
                    "<Super>a"
                ];
                switch-right = [
                    "<Super>Right"
                    "<Super>d"
                ];
                move-down-workspace = [
                    "<Shift><Super>Down"
                    "<Shift><Super>s"
                ];
                move-up-workspace = [
                    "<Shift><Super>Up"
                    "<Shift><Super>w"
                ];
                move-to-workspace-down = [
                    "<Super>Down"
                    "<Super>s"
                ];
                move-to-workspace-up = [
                    "<Super>Up"
                    "<Super>w"
                ];
                switch-monitor-above = [""];
                switch-monitor-below = [""];
                switch-monitor-left = [""];
                switch-monitor-right = [""];
            };

            "org/gnome/shell/extensions/blur-my-shell/panel" = {
                override-background = false;
                unblur-in-overview = false;
                static-blur = false;
            };

            "org/gnome/shell/extensions/dash-to-dock" = {
                dock-position = "RIGHT";
                extend-height = true;
                scroll-action = "switch-workspace";
                middle-click-action = "launch";
                custom-theme-shrink = true;
                transparency-mode = "FIXED";
                background-opacity = 0.90;
            };

            "org/gnome/desktop/interface" = {
                show-battery-percentage = true;
                color-scheme = "prefer-dark";
                accent-color = "pink";
                font-antialiasing = "standard";
                font-hinting = "full";
                font-name = "Ubuntu Sans 12";
                monospace-font-name = "Ubuntu Sans Mono 12";
                icon-theme = "Yaru";
                clock-format = "12h";
                cursor-theme = "Yaru";
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
}
