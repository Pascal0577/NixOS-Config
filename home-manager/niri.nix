{ inputs, config, pkgs, lib, ... }:

{
    imports = [
        inputs.niri.homeModules.niri
    ];

    programs.niri.settings = with config.lib.niri.actions; let
        bar = "waybar";
        launcher = "walker";
        lockscreen = "swaylock";
        terminal = "ghostty";
    in {
        hotkey-overlay.skip-at-startup = true;
        prefer-no-csd = true;

        xwayland-satellite = {
            enable = true;
            path = lib.getExe pkgs.xwayland-satellite;
        };

        environment = {
            QT_QPA_PLATFORM = "wayland";
        };

        spawn-at-startup = [
            { argv = [bar]; }
            { argv = ["swaybg" "--image" "~/Pictures/Wallpapers/TranscodedWallpaper.png"]; }
        ];

        binds = {
            # Focusing
            "Mod+Left".action = focus-column-left;
            "Mod+A".action = focus-column-left;
            "Mod+Right".action = focus-column-right;
            "Mod+D".action = focus-column-right;
            "Mod+Down".action = focus-window-or-workspace-down;
            "Mod+S".action = focus-window-or-workspace-down;
            "Mod+Up".action = focus-window-or-workspace-up;
            "Mod+W".action = focus-window-or-workspace-up;
            "Mod+WheelScrollDown" = {
                action = focus-workspace-down;
                cooldown-ms = 150;
            };
            "Mod+WheelScrollUp" = {
                action = focus-workspace-up;
                cooldown-ms = 150;
            };

            # Moving
            "Mod+Shift+Left".action = move-column-left;
            "Mod+Shift+A".action = move-column-left;
            "Mod+Shift+Right".action = move-column-right;
            "Mod+Shift+D".action = move-column-right;
            "Mod+Shift+Down".action = move-window-down-or-to-workspace-down;
            "Mod+Shift+S".action = move-window-down-or-to-workspace-down;
            "Mod+Shift+Up".action = move-window-up-or-to-workspace-up;
            "Mod+Shift+W".action = move-window-up-or-to-workspace-up;

            "Mod+Period".action = consume-or-expel-window-right;
            "Mod+Comma".action = consume-or-expel-window-left;
            
            "Mod+Minus".action = set-column-width "-10%";
            "Mod+Equal".action = set-column-width "+10%";
            "Mod+Shift+Minus".action = set-window-height "-10%";
            "Mod+Shift+Equal".action = set-window-height "+10%";
            "Mod+F".action = maximize-column;
            "Mod+Shift+F".action = fullscreen-window;

            # Miscellaneous
            "Mod+V".action = toggle-window-floating;
            "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;
            "Mod+T".action = toggle-column-tabbed-display;
            "Mod+Shift+E".action = quit;
            "Mod+C".action = center-column;
            "Mod+O" = { 
                action = toggle-overview;
                repeat = false;
            };
            "Mod+Q" = {
                action = close-window;
                repeat = false;
            };
            "Mod+Escape" = {
                action = toggle-keyboard-shortcuts-inhibit;
                allow-inhibiting = false;
            };

            # Execs
            "Print".action = screenshot;
            "Ctrl+Print".action = screenshot-window;
            # This just doesn't exist for some reason lol
            # "Shift+Print".action = screenshot-screen;
            "Mod+Return".action = spawn terminal;
            "Mod+Space".action = spawn launcher;
            "Mod+L".action = spawn lockscreen;

            # Control keys
            "XF86AudioPlay" = {
                allow-when-locked = true;
                action = spawn-sh "playerctl play-pause";
            };
            "XF86AudioStop" = {
                allow-when-locked = true;
                action = spawn-sh "playerctl stop";
            };
            "XF86AudioPrev" = {
                allow-when-locked = true;
                action = spawn-sh "playerctl previous";
            };
            "XF86AudioNext" = {
                allow-when-locked = true;
                action = spawn-sh "playerctl next";
            };

            "XF86AudioRaiseVolume" = {
                allow-when-locked = true;
                action = spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
            };
            "XF86AudioLowerVolume" = {
                allow-when-locked = true;
                action = spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
            };
            "XF86AudioMute" = {
                allow-when-locked = true;
                action = spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            };
            "XF86MonBrightnessUp" = {
                allow-when-locked = true;
                action = spawn-sh "brightnessctl --class=backlight set +10%";
            };
            "XF86MonBrightnessDown" = {
                allow-when-locked = true;
                action = spawn-sh "brightnessctl --class=backlight set -10%";
            };
        };

        input = {
            focus-follows-mouse.enable = true;
            keyboard.numlock = true;
            tablet.enable = false;
            touch.enable = false;
            trackball.enable = false;
            trackpoint.enable = false;
        };

        outputs.eDP-1 = {
            enable = true;
            scale = 1.0;
            variable-refresh-rate = "on-demand";
        };

        layout = {
            always-center-single-column = true;
            center-focused-column = "never";
            default-column-display = "normal"; # Can be normal or tabbed
            empty-workspace-above-first = true;
            gaps = 16;

            struts = {
                bottom = -8;
                top = -8;
                left = 8;
                right = 8;
            };

            border = {
                enable = true;
                width = 4;
                active = {
                    gradient = {
                        angle = 45;
                        from = "#D5B69D";
                        to = "#D5B69D";
                        relative-to = "workspace-view";
                    };
                };
                inactive.color = "#505050";
                urgent.color = "#9b0000";
            };

            focus-ring.enable = false;

            shadow = {
                enable = true;
            };

            preset-column-widths = [
                { proportion = 1. / 3.; }
                { proportion = 1. / 2.; }
                { proportion = 2. / 3.; }
            ];

            tab-indicator = {
                enable = true;
                corner-radius = 0.000000;
                gap = 5.000000;
                gaps-between-tabs = 0.000000;
                hide-when-single-tab = true;
                length.total-proportion = 0.500000;
                place-within-column = false;
                position = "bottom";
                width = 4.000000;
                # active.color = null;
                # inactive.color = null;
                # urgent.color = null;
            };

            # Come back to this later. Way too much to do right now
            # animations = {};
        };

        gestures = {
            hot-corners.enable = false;
        };



        switch-events = {
            lid-close.action = spawn [lockscreen];
        };

    };
}
