{ lib, username, config, inputs, pkgs, ... }:
let
    hue = config.lib.stylix.colors;
in
{
    options.mySystem.desktop.oxwm.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable my OXWM module";
    };

    config = lib.mkIf config.mySystem.desktop.oxwm.enable {
        services = {
            displayManager.ly.enable = true;
            xserver = {
                enable = lib.mkForce true;
                windowManager.oxwm = {
                    enable = true;
                    package = inputs.oxwm.packages.${pkgs.stdenv.hostPlatform.system}.oxwm;
                };
            };
        };

        home-manager.users.${username} = {
            imports = [ inputs.oxwm.homeManagerModules.default ];
            programs.oxwm = {
                enable = true;
                settings = {
                    terminal = "alacritty";
                    modkey = "Mod4";
                    layoutSymbol = {
                        tiling = "[T]";
                        normie = "[F]";
                        tabbed = "[=]";
                    };
                    autostart = [
                        
                    ];
                    binds = [
                        {
                            key = "Space";
                            action = ''oxwm.spawn({ "sh", "-c", "${config.mySystem.applications.launcher.command}" })'';
                        }
                        {
                            key = "Return";
                            action = ''oxwm.spawn_terminal()'';
                        }
                    ];
                    chords = [
                        {
                            notes = [
                                {
                                    mods = [ "Mod4" "Shift" ];
                                    key = "Space";
                                }
                                {
                                    mods = [];
                                    key = "T";
                                }
                            ];
                            action = ''oxwm.spawn_terminal()'';
                        }
                    ];
                    border = {
                        width = 3;
                        focusedColor = "${hue.base0D-hex}";
                        unfocusedColor = "${hue.base03-hex}";
                    };
                    gaps = {
                        smart = "enabled";
                        inner = [5 5];
                        outer = [5 5];
                    };
                    bar = {
                        font = "JetBrainsMono Nerd Font:style=Regular:size=12";
                        hideVacantTags = false;
                        unoccupiedScheme = [
                            "${hue.base05-hex}"
                            "${hue.base00-hex}"
                            "${hue.base03-hex}"
                        ];
                        occupiedScheme = [
                            "${hue.base0C-hex}"
                            "${hue.base00-hex}"
                            "${hue.base0C-hex}"
                        ];
                        selectedScheme = [
                            "${hue.base0C-hex}"
                            "${hue.base00-hex}"
                            "${hue.base0E-hex}"
                        ];
                        urgentScheme = [
                            "${hue.base08-hex}"
                            "${hue.base00-hex}"
                            "${hue.base08-hex}"
                        ];
                        blocks = [
                            {
                                kind = "ram";
                                format = "Ram: {used}/{total} GB";
                                interval = 5;
                                color = "${hue.base0C-hex}";
                                underline = true;
                            }
                            {
                                kind = "static";
                                text = "|";
                                interval = 999999999;
                                color = "${hue.base0E-hex}";
                                underline = false;
                            }
                            {
                                kind = "shell";
                                format = "{}";
                                command = "uname -r";
                                interval = 999999999;
                                color = "${hue.base08-hex}";
                                underline = true;
                            }
                            {
                                kind = "static";
                                text = "|";
                                interval = 999999999;
                                color = "${hue.base0E-hex}";
                                underline = false;
                            }
                            {
                                kind = "datetime";
                                format = "{}";
                                date_format = "%a, %b %d - %-I:%M %P";
                                interval = 1;
                                color = "${hue.base0C-hex}";
                                underline = true;
                            }
                            {
                                kind = "battery";
                                format = "Bat: {}%";
                                charging = "⚡ Bat: {}%";
                                discharging = "- Bat: {}%";
                                full = "✓ Bat: {}%";
                                interval = 30;
                                color = "${hue.base0B-hex}";
                                underline = true;
                            }
                        ];
                    };
                    rules = [];
                };
            };
        };
    };
}
