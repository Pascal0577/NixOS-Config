{ lib, username, config, inputs, pkgs, ... }:
let
    hue = config.lib.stylix.colors;
    inherit (lib) toInt;
in
{
    options.mySystem.desktop.oxwm.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable my OXWM module";
    };

    config = lib.mkIf config.mySystem.desktop.oxwm.enable {
        environment.systemPackages = with pkgs; [ xclip maim bc sysstat ];
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
                        { key = "D"; action = ''oxwm.spawn({ "sh", "-c", "dmenu_run -l 10" })''; }
                        { key = "Return"; action = ''oxwm.spawn_terminal()''; }
                        { key = "Q"; action = ''oxwm.client.kill()''; }
                        { key = "A"; action = "oxwm.toggle_gaps()"; }
                        { key = "J"; action = "oxwm.client.focus_stack(1)"; }
                        { key = "Up"; action = "oxwm.client.focus_stack(1)"; }
                        { key = "K"; action = "oxwm.client.focus_stack(-1)"; }
                        { key = "Down"; action = "oxwm.client.focus_stack(-1)"; }
                        { key = "H"; action = "oxwm.set_master_factor(5)"; }
                        { key = "L"; action = "oxwm.set_master_factor(-5)"; }
                        { key = "V"; action = "oxwm.client.toggle_floating()"; }
                        { key = "S"; action = ''oxwm.spawn({ "sh", "-c", "maim -s | xclip -selection clipboard -t image/png" })''; }
                        {
                            mods = [ "Mod4" "Shift" ];
                            key = "F";
                            action = "oxwm.client.toggle_fullscreen()";
                        }
                        {
                            mods = [ "Mod4" "Shift" ];
                            key = "Q";
                            action = "oxwm.quit()";
                        }
                        {
                            mods = [ "Mod4" "Shift" ];
                            key = "R";
                            action = "oxwm.restart()";
                        }
                        {
                            mods = [ "Mod4" "Shift" ];
                            key = "J";
                            action = "oxwm.client.move_stack(1)";
                        }
                        {
                            mods = [ "Mod4" "Shift" ];
                            key = "K";
                            action = "oxwm.client.move_stack(-1)";
                        }
                    ] ++
                    (lib.concatMap (num: [
                        { key = "${num}"; action = "oxwm.tag.view(${toString (toInt num - 1)})"; }
                        {
                            mods = [ "Mod4" "Shift" ];
                            key = "${num}";
                            action = "oxwm.tag.move_to(${toString (toInt num - 1)})";
                        }
                    ]) [ "1" "2" "3" "4" "5" "6" "7" "8" "9" ]);
                    chords = [
                        {
                            notes = [
                                { mods = [ "Mod4" "Shift" ]; key = "Space"; }
                                { mods = []; key = "T"; }
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
                                underline = false;
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
                                format = "CPU: {}%";
                                command = ''echo 100 - $(mpstat | awk 'NR == 4 {print $13}') | bc'';
                                interval = 3;
                                color = "${hue.base08-hex}";
                                underline = false;
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
                                underline = false;
                            }
                            {
                                kind = "static";
                                text = "|";
                                interval = 999999999;
                                color = "${hue.base0E-hex}";
                                underline = false;
                            }
                            {
                                kind = "battery";
                                format = "Bat: {}%";
                                charging = "⚡ Bat: {}%";
                                discharging = "- Bat: {}%";
                                full = "✓ Bat: {}%";
                                interval = 30;
                                color = "${hue.base0B-hex}";
                                underline = false;
                            }
                        ];
                    };
                    rules = [
                        # { match.class = "Zen"; focus = true; tag = 0; }
                    ];
                };
            };
        };
    };
}
