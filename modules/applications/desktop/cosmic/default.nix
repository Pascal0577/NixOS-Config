{ config, lib, username, ... }:
let
    hue = config.lib.stylix.colors;
    cfg = config.desktop.cosmic;
in
{
    options.desktop.cosmic = {
        enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Whether to enable my COSMIC module";
        };

        accentRed = lib.mkOption {
            type = lib.types.str;
            default = "${hue.base0D-dec-r}";
            description = "The red component of the accent color";
        };

        accentGreen = lib.mkOption {
            type = lib.types.str;
            default = "${hue.base0D-dec-g}";
            description = "The green component of the accent color";
        };

        accentBlue = lib.mkOption {
            type = lib.types.str;
            default = "${hue.base0D-dec-b}";
            description = "The blue component of the accent color";
        };
    };

    config = lib.mkIf config.desktop.cosmic.enable {
        services.displayManager.cosmic-greeter.enable = true;
        services.system76-scheduler.enable = true;
        services.desktopManager.cosmic = {
            enable = true;
            xwayland.enable = true;
        };

        home-manager.users.${username} = { lib, pkgs, config, ... }: {
            home.activation = {
                cosmicTheme = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
                    ${lib.getExe pkgs.cosmic-settings} appearance import \
                    ${config.home.homeDirectory}/.config/cosmic/stylix.ron
                '';
            };

            xdg.configFile."cosmic/stylix.ron".text = ''
                (
                    palette: Dark((
                        name: "stylix",
                        bright_red: (
                            red: ${hue.base08-dec-r},
                            green: ${hue.base08-dec-g},
                            blue: ${hue.base08-dec-b},
                            alpha: 1.0,
                        ),
                        bright_green: (
                            red: ${hue.base0B-dec-r},
                            green: ${hue.base0B-dec-g},
                            blue: ${hue.base0B-dec-b},
                            alpha: 1.0,
                        ),
                        bright_orange: (
                            red: ${hue.base09-dec-r},
                            green: ${hue.base09-dec-g},
                            blue: ${hue.base09-dec-b},
                            alpha: 1.0,
                        ),
                        gray_1: (
                            red: ${hue.base03-dec-r},
                            green: ${hue.base03-dec-g},
                            blue: ${hue.base03-dec-b},
                            alpha: 1.0,
                        ),
                        gray_2: (
                            red: ${hue.base04-dec-r},
                            green: ${hue.base04-dec-g},
                            blue: ${hue.base04-dec-b},
                            alpha: 1.0,
                        ),
                        neutral_0: (
                            red: 0.0,
                            green: 0.0,
                            blue: 0.0,
                            alpha: 1.0,
                        ),
                        neutral_1: (
                            red: ${hue.base00-dec-r},
                            green: ${hue.base00-dec-g},
                            blue: ${hue.base00-dec-b},
                            alpha: 1.0,
                        ),
                        neutral_2: (
                            red: ${hue.base01-dec-r},
                            green: ${hue.base01-dec-g},
                            blue: ${hue.base01-dec-b},
                            alpha: 1.0,
                        ),
                        neutral_3: (
                            red: ${hue.base02-dec-r},
                            green: ${hue.base02-dec-g},
                            blue: ${hue.base02-dec-b},
                            alpha: 1.0,
                        ),
                        neutral_4: (
                            red: ${hue.base02-dec-r},
                            green: ${hue.base02-dec-g},
                            blue: ${hue.base02-dec-b},
                            alpha: 1.0,
                        ),
                        neutral_5: (
                            red: ${hue.base03-dec-r},
                            green: ${hue.base03-dec-g},
                            blue: ${hue.base03-dec-b},
                            alpha: 1.0,
                        ),
                        neutral_6: (
                            red: ${hue.base03-dec-r},
                            green: ${hue.base03-dec-g},
                            blue: ${hue.base03-dec-b},
                            alpha: 1.0,
                        ),
                        neutral_7: (
                            red: ${hue.base04-dec-r},
                            green: ${hue.base04-dec-g},
                            blue: ${hue.base04-dec-b},
                            alpha: 1.0,
                        ),
                        neutral_8: (
                            red: ${hue.base04-dec-r},
                            green: ${hue.base04-dec-g},
                            blue: ${hue.base04-dec-b},
                            alpha: 1.0,
                        ),
                        neutral_9: (
                            red: ${hue.base05-dec-r},
                            green: ${hue.base05-dec-g},
                            blue: ${hue.base05-dec-b},
                            alpha: 1.0,
                        ),
                        neutral_10: (
                            red: 1.0,
                            green: 1.0,
                            blue: 1.0,
                            alpha: 1.0,
                        ),
                        accent_blue: (
                            red: ${hue.base0C-dec-r},
                            green: ${hue.base0C-dec-g},
                            blue: ${hue.base0C-dec-b},
                            alpha: 1.0,
                        ),
                        accent_indigo: (
                            red: ${hue.base0D-dec-r},
                            green: ${hue.base0D-dec-g},
                            blue: ${hue.base0D-dec-b},
                            alpha: 1.0,
                        ),
                        accent_purple: (
                            red: ${hue.base0E-dec-r},
                            green: ${hue.base0E-dec-g},
                            blue: ${hue.base0E-dec-b},
                            alpha: 1.0,
                        ),
                        accent_pink: (
                            red: ${hue.base0E-dec-r},
                            green: ${hue.base0E-dec-g},
                            blue: ${hue.base0E-dec-b},
                            alpha: 1.0,
                        ),
                        accent_red: (
                            red: ${hue.base08-dec-r},
                            green: ${hue.base08-dec-g},
                            blue: ${hue.base08-dec-b},
                            alpha: 1.0,
                        ),
                        accent_orange: (
                            red: ${hue.base09-dec-r},
                            green: ${hue.base09-dec-g},
                            blue: ${hue.base09-dec-b},
                            alpha: 1.0,
                        ),
                        accent_yellow: (
                            red: ${hue.base0A-dec-r},
                            green: ${hue.base0A-dec-g},
                            blue: ${hue.base0A-dec-b},
                            alpha: 1.0,
                        ),
                        accent_green: (
                            red: ${hue.base0B-dec-r},
                            green: ${hue.base0B-dec-g},
                            blue: ${hue.base0B-dec-b},
                            alpha: 1.0,
                        ),
                        accent_warm_grey: (
                            red: ${hue.base03-dec-r},
                            green: ${hue.base03-dec-g},
                            blue: ${hue.base03-dec-b},
                            alpha: 1.0,
                        ),
                        ext_warm_grey: (
                            red: ${hue.base03-dec-r},
                            green: ${hue.base03-dec-g},
                            blue: ${hue.base03-dec-b},
                            alpha: 1.0,
                        ),
                        ext_red: (
                            red: ${hue.base08-dec-r},
                            green: ${hue.base08-dec-g},
                            blue: ${hue.base08-dec-b},
                            alpha: 1.0,
                        ),
                        ext_orange: (
                            red: ${hue.base09-dec-r},
                            green: ${hue.base09-dec-g},
                            blue: ${hue.base09-dec-b},
                            alpha: 1.0,
                        ),
                        ext_yellow: (
                            red: ${hue.base0A-dec-r},
                            green: ${hue.base0A-dec-g},
                            blue: ${hue.base0A-dec-b},
                            alpha: 1.0,
                        ),
                        ext_green: (
                            red: ${hue.base0B-dec-r},
                            green: ${hue.base0B-dec-g},
                            blue: ${hue.base0B-dec-b},
                            alpha: 1.0,
                        ),
                        ext_blue: (
                            red: ${hue.base0C-dec-r},
                            green: ${hue.base0C-dec-g},
                            blue: ${hue.base0C-dec-b},
                            alpha: 1.0,
                        ),
                        ext_indigo: (
                            red: ${hue.base0D-dec-r},
                            green: ${hue.base0D-dec-g},
                            blue: ${hue.base0D-dec-b},
                            alpha: 1.0,
                        ),
                        ext_purple: (
                            red: ${hue.base0E-dec-r},
                            green: ${hue.base0E-dec-g},
                            blue: ${hue.base0E-dec-b},
                            alpha: 1.0,
                        ),
                        ext_pink: (
                            red: ${hue.base0E-dec-r},
                            green: ${hue.base0E-dec-g},
                            blue: ${hue.base0E-dec-b},
                            alpha: 1.0,
                        ),
                    )),
                    neutral_tint: Some((
                        red: ${hue.base03-dec-r},
                        green: ${hue.base03-dec-g},
                        blue: ${hue.base03-dec-b},
                    )),
                    bg_color: Some((
                        red: ${hue.base00-dec-r},
                        green: ${hue.base00-dec-g},
                        blue: ${hue.base00-dec-b},
                        alpha: 1.0,
                    )),
                    primary_container_bg: Some((
                        red: ${hue.base01-dec-r},
                        green: ${hue.base01-dec-g},
                        blue: ${hue.base01-dec-b},
                        alpha: 1.0,
                    )),
                    secondary_container_bg: None,
                    text_tint: Some((
                        red: ${hue.base05-dec-r},
                        green: ${hue.base05-dec-g},
                        blue: ${hue.base05-dec-b},
                    )),
                    accent: Some((
                        red: ${cfg.accentRed},
                        green: ${cfg.accentGreen},
                        blue: ${cfg.accentBlue},
                    )),
                    window_hint: Some((
                        red: ${cfg.accentRed},
                        green: ${cfg.accentGreen},
                        blue: ${cfg.accentBlue},
                    )),
                )
            '';
        };
    };
}
