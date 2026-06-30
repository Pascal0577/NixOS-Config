{ pkgs, username, config, lib, ... }:
let
    playerctl = lib.getExe pkgs.playerctl;
    brightnessctl = lib.getExe pkgs.brightnessctl;
in
{
    config = lib.mkMerge [
        (lib.mkIf (config.mySystem.desktop.choice == "niri") {
            programs.niri = {
                enable = true;
                package = pkgs.niri;
            };

            services.displayManager.ly.enable = true;
            services.gnome.gnome-keyring.enable = true;
            environment.sessionVariables = { NIXOS_OZONE_WL = "1"; };

            xdg.portal = {
                enable = true;
                extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
            };

            systemd.user.services.niri-flake-polkit = {
                description = "PolicyKit Authentication Agent";
                wantedBy = [ "niri.service" ];
                after = [ "graphical-session.target" ];
                partOf = [ "graphical-session.target" ];
                serviceConfig = {
                    Type = "simple";
                    ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
                    Restart = "on-failure";
                    RestartSec = 1;
                    TimeoutStopSec = 10;
                };
            };

            home-manager.users.${username} = {
                home.file.".config/niri/config.kdl".text = ''
                    input {
                        keyboard {
                            xkb {
                                layout ""
                                model ""
                                rules ""
                                variant ""
                            }
                            repeat-delay 600
                            repeat-rate 25
                            track-layout "global"
                            numlock
                        }
                        touchpad {
                            tap
                            natural-scroll
                        }
                        trackpoint { off; }
                        trackball { off; }
                        tablet { off; }
                        touch { off; }
                        focus-follows-mouse
                    }
                    output "HDMI-A-1" {
                        scale 1.000000
                        transform "normal"
                        mode "2560x1440@143.967000"
                        variable-refresh-rate on-demand=true
                    }
                    output "eDP-1" {
                        scale 1.000000
                        transform "normal"
                        variable-refresh-rate on-demand=true
                    }
                    screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"
                    prefer-no-csd
                    layout {
                        gaps 8
                        struts {
                            left 6
                            right 6
                            top -2
                            bottom -2
                        }
                        focus-ring { off; }
                        border {
                            width 4
                            active-color "#7daea3"
                            inactive-color "#7c6f64"
                        }
                        shadow {
                            on
                            offset x=0.000000 y=5.000000
                            softness 30.000000
                            spread 5.000000
                            draw-behind-window false
                            color "#00000070"
                        }
                        tab-indicator {
                            hide-when-single-tab
                            gap 5.000000
                            width 4.000000
                            length total-proportion=0.500000
                            position "bottom"
                            gaps-between-tabs 0.000000
                            corner-radius 0.000000
                        }
                        default-column-width
                        preset-column-widths {
                            proportion 0.333333
                            proportion 0.500000
                            proportion 0.666667
                        }
                        center-focused-column "never"
                        always-center-single-column
                        empty-workspace-above-first
                    }
                    cursor {
                        xcursor-theme "${config.stylix.cursor.name}"
                        xcursor-size ${lib.toString config.stylix.cursor.size}
                    }
                    hotkey-overlay { skip-at-startup; }
                    environment { "QT_QPA_PLATFORM" "wayland"; }
                    binds {
                        Ctrl+Print { screenshot-window; }
                        Mod+A { focus-column-left; }
                        Mod+C { center-column; }
                        Mod+Comma { consume-or-expel-window-left; }
                        Mod+D { focus-column-right; }
                        Mod+Down { focus-window-or-workspace-down; }
                        Mod+Equal { set-column-width "+10%"; }
                        Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }
                        Mod+F { maximize-column; }
                        ${lib.optionalString config.mySystem.applications.noctalia.enable ''
                        Mod+L { spawn-sh "noctalia-shell ipc call lockScreen lock"; }
                        ''}
                        Mod+Left { focus-column-left; }
                        Mod+Minus { set-column-width "-10%"; }
                        Mod+O repeat=false { toggle-overview; }
                        Mod+Period { consume-or-expel-window-right; }
                        Mod+Q repeat=false { close-window; }
                        Mod+Return { spawn-sh "${config.mySystem.applications.terminal.openWindow}"; }
                        Mod+Right { focus-column-right; }
                        Mod+S { focus-window-or-workspace-down; }
                        Mod+Shift+A { move-column-left; }
                        Mod+Shift+D { move-column-right; }
                        Mod+Shift+Down { move-window-down-or-to-workspace-down; }
                        Mod+Shift+E { quit; }
                        Mod+Shift+Equal { set-window-height "+10%"; }
                        Mod+Shift+F { fullscreen-window; }
                        Mod+Shift+Left { move-column-left; }
                        Mod+Shift+Minus { set-window-height "-10%"; }
                        Mod+Shift+Right { move-column-right; }
                        Mod+Shift+S { move-window-down-or-to-workspace-down; }
                        Mod+Shift+Up { move-window-up-or-to-workspace-up; }
                        Mod+Shift+V { switch-focus-between-floating-and-tiling; }
                        Mod+Shift+W { move-window-up-or-to-workspace-up; }
                        Mod+Space { spawn-sh "${config.mySystem.applications.launcher.command}"; }
                        Mod+T { toggle-column-tabbed-display; }
                        Mod+Up { focus-window-or-workspace-up; }
                        Mod+V { toggle-window-floating; }
                        Mod+W { focus-window-or-workspace-up; }
                        Mod+WheelScrollDown cooldown-ms=150 { focus-workspace-down; }
                        Mod+WheelScrollUp cooldown-ms=150 { focus-workspace-up; }
                        Mod+XF86AudioNext allow-when-locked=true { spawn-sh "${playerctl} position 5+"; }
                        Mod+XF86AudioPrev allow-when-locked=true { spawn-sh "${playerctl} position 5-"; }
                        Print { screenshot; }
                        Shift+Print { screenshot-screen; }
                        XF86AudioLowerVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-"; }
                        XF86AudioMute allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
                        XF86AudioNext allow-when-locked=true { spawn-sh "${playerctl} next"; }
                        XF86AudioPlay allow-when-locked=true { spawn-sh "${playerctl} play-pause"; }
                        XF86AudioPrev allow-when-locked=true { spawn-sh "${playerctl} previous"; }
                        XF86AudioRaiseVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+"; }
                        XF86AudioStop allow-when-locked=true { spawn-sh "${playerctl} stop"; }
                        XF86MonBrightnessDown allow-when-locked=true { spawn "${brightnessctl}" "set" "5%-"; }
                        XF86MonBrightnessUp allow-when-locked=true { spawn "${brightnessctl}" "set" "5%+"; }
                    }
                    ${lib.optionalString config.mySystem.applications.noctalia.enable ''
                    switch-events { lid-close { spawn "noctalia-shell" "ipc" "call" "lockScreen" "lock"; }; }
                    ''}
                    window-rule {
                        geometry-corner-radius 10.000000 10.000000 10.000000 10.000000
                        clip-to-geometry true
                    }
                    window-rule {
                        match app-id="com.mitchellh.ghostty"
                        match app-id="foot"
                        default-column-width { proportion 0.500000; }
                    }
                    window-rule {
                        match title="ELDEN RING™"
                        variable-refresh-rate true
                    }
                    window-rule {
                        match app-id="my.file-chooser"
                        match app-id="^th[^/]*.exe"
                        match app-id="^東方紅魔郷.exe"
                        open-floating true
                    }
                    window-rule {
                        match app-id="^foot$"
                        background-effect { blur true; }
                    }
                    xwayland-satellite { path "${lib.getExe pkgs.xwayland-satellite}"; }
                '';
            };
        })
    ];
}
