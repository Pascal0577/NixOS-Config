{ inputs, pkgs, username, config, lib, ... }:
let
    niri-optimized = pkgs.niri-unstable.overrideAttrs (oldAttrs: {
        env = (oldAttrs.env or {}) // {
            RUSTFLAGS = "${oldAttrs.env.RUSTFLAGS or ""} -C opt-level=3 -C target-cpu=native -C codegen-units=1 -C lto=thin";
        };
    });
in
{
    options.mySystem.desktop.niri = {
        enable = lib.mkEnableOption "niri";
        stable = lib.mkEnableOption "niri-stable";
    };

    imports = [ inputs.niri.nixosModules.niri ];

    config = lib.mkIf config.mySystem.desktop.niri.enable {
        nixpkgs.overlays = [ inputs.niri.overlays.niri ];
        niri-flake.cache.enable = true;

        programs.niri = {
            enable = true;
            package = if config.mySystem.desktop.niri.stable
                        then niri-optimized
                        else pkgs.niri-stable;
        };

        # applications.noctalia.enable = true;
        environment.sessionVariables = { NIXOS_OZONE_WL = "1"; };
        services.displayManager.ly.enable = true;
        systemd.user.services.niri-flake-polkit.serviceConfig.ExecStart = 
            lib.mkForce "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";


        home-manager.users.${username} = {
            stylix.targets.niri.enable = true;
            programs.niri.settings = with config.home-manager.users.${username}.lib.niri.actions; {
                hotkey-overlay.skip-at-startup = true;
                prefer-no-csd = true;
                environment.QT_QPA_PLATFORM = "wayland";

                xwayland-satellite = {
                    enable = true;
                    path = lib.getExe pkgs.xwayland-satellite;
                };

                spawn-at-startup = [
                    { argv = [ "cosmic-ext-alternative-startup" ]; }
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
                    "Mod+L".action.spawn-sh = "noctalia-shell ipc call lockScreen lock";
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
                    "Print".action.screenshot = [];
                    "Shift+Print".action.screenshot-screen = [];
                    "Ctrl+Print".action.screenshot-window = [];
                    "Mod+Return".action.spawn-sh = [ "${config.mySystem.applications.terminal.openWindow}" ];
                    "Mod+Space".action.spawn-sh = [ "${config.mySystem.applications.launcher.command}" ];

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
                    "Mod+XF86AudioPrev" = {
                        allow-when-locked = true;
                        action = spawn-sh "playerctl position 5-";
                    };
                    "Mod+XF86AudioNext" = {
                        allow-when-locked = true;
                        action = spawn-sh "playerctl position 5+";
                    };
                    "XF86AudioRaiseVolume" = {
                        allow-when-locked = true;
                        action = spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+";
                    };
                    "XF86AudioLowerVolume" = {
                        allow-when-locked = true;
                        action = spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
                    };
                    "XF86AudioMute" = {
                        allow-when-locked = true;
                        action = spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
                    };
                    "XF86MonBrightnessUp" = {
                        allow-when-locked = true;
                        action.spawn = [ "${lib.getExe pkgs.brightnessctl}" "set" "5%+" ];
                    };
                    "XF86MonBrightnessDown" = {
                        allow-when-locked = true;
                        action.spawn = [ "${lib.getExe pkgs.brightnessctl}" "set" "5%-" ];
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

                outputs = {
                    eDP-1 = {
                        enable = true;
                        scale = 1.0;
                        variable-refresh-rate = "on-demand";
                    };

                    HDMI-A-1 = {
                        enable = true;
                        scale = 1.0;
                        variable-refresh-rate = true;
                        mode.height = 1440;
                        mode.width = 2560;
                        mode.refresh = 143.967;
                    };
                };

                layout = {
                    always-center-single-column = true;
                    center-focused-column = "never";
                    default-column-display = "normal"; # Can be normal or tabbed
                    empty-workspace-above-first = true;
                    focus-ring.enable = false;
                    gaps = 8;

                    struts = {
                        bottom = -2;
                        top = -2;
                        left = 6;
                        right = 6;
                    };

                    border = {
                        enable = true;
                        width = 4;
                    };

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
                    };
                };

                animations = {
                    window-open = {
                        enable = true;
                        kind.easing = {
                            curve = "ease-out-expo";
                            duration-ms = 350;
                        };
                        custom-shader = ''
                            vec4 open_color(vec3 coords_geo, vec3 size_geo) {
                                float angle = 2.0 * 3.14159265 * niri_clamped_progress;
                                float scale = 1.0 - (1.0 - niri_clamped_progress) * 0.5;
                                mat2 rot = mat2(cos(angle), sin(angle),
                                                -sin(angle),  cos(angle));
                                vec3 coords_new = vec3(rot * (coords_geo.xy - vec2(0.5)) / scale + vec2(0.5), 1.0);

                                vec3 coords_tex = niri_geo_to_tex * coords_new;
                                vec4 color = texture2D(niri_tex, coords_tex.st);

                                color *= niri_clamped_progress;
                                return color;
                            }
                        '';
                    };

                    window-close = {
                        enable = true;
                        kind.easing = {
                            curve = "ease-out-expo";
                            duration-ms = 1000;
                        };
                        custom-shader = ''
                            vec4 close_color(vec3 coords_geo, vec3 size_geo) {
                                float angle = 2.0 * 3.14159265 * niri_clamped_progress;
                                float scale = 1.0 - niri_clamped_progress * 0.5;
                                mat2 rot = mat2(cos(angle), -sin(angle),
                                                sin(angle),  cos(angle));
                                vec3 coords_new = vec3(rot * (coords_geo.xy - vec2(0.5)) / scale + vec2(0.5), 1.0);

                                vec3 coords_tex = niri_geo_to_tex * coords_new;
                                vec4 color = texture2D(niri_tex, coords_tex.st);

                                color *= (1.0 - niri_clamped_progress);
                                return color;
                            }
                        '';
                    };
                };

                gestures = {
                    hot-corners.enable = true;
                };

                window-rules = [
                    {
                        geometry-corner-radius = {
                            bottom-left = 10.0;
                            bottom-right = 10.0;
                            top-left = 10.0;
                            top-right = 10.0;
                        };
                        clip-to-geometry = true;
                    }
                    {
                        matches = [
                            { app-id = "com.mitchellh.ghostty"; }
                            { app-id = "foot"; }
                        ];
                        default-column-width.proportion = 0.5;
                    }
                    {
                        # For games to have VRR
                        matches = [{
                            app-id = "steam_app_0";
                        }];
                        # variable-refresh-rate = true;
                    }
                    {
                        matches = [{
                            app-id = "my.file-chooser";
                        }];
                        open-floating = true;
                    }
                ];

                switch-events = {
                    lid-close.action = spawn "noctalia-shell" "ipc" "call" "lockScreen" "lock";
                };
            };

            systemd.user.services.swaybg = {
                Unit = {
                    PartOf = "graphical-session.target";
                    After = "graphical-session.target";
                    Requisite = "graphical-session.target";
                };
                Service = {
                    ExecStart = "${pkgs.swaybg}/bin/swaybg -m fill -i ${config.stylix.image}";
                    Restart = "on-failure";
                };
                Install = {
                    WantedBy = [ "graphical-session.target" ];
                };
            };
        };
    };
}
