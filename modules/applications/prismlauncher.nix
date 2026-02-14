{ username, config, lib, pkgs, ... }:
let
    hue = config.lib.stylix.colors;
in
{
    options.applications.prismlauncher.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable my PrismLauncher module";
    };

    config = lib.mkIf config.applications.prismlauncher.enable {
        environment.systemPackages = [ pkgs.prismlauncher ];
        home-manager.users.${username} = {
            home.file.".local/share/PrismLauncher/themes/Stylix/theme.json".text = builtins.toJSON {
                colors = {
                    AlternateBase = "#${hue.base01-hex}";
                    Base = "#${hue.base00-hex}";
                    BrightText = "#${hue.base07-hex}";
                    Button = "#${hue.base02-hex}";
                    ButtonText = "#${hue.base07-hex}";
                    Highlight = "#${hue.base02-hex}";
                    HighlightedText = "#${hue.base07-hex}";
                    Link = "#${hue.base04-hex}";
                    Text = "#${hue.base05-hex}";
                    ToolTipBase = "#${hue.base06-hex}";
                    ToolTipText = "#${hue.base06-hex}";
                    Window = "#${hue.base01-hex}";
                    WindowText = "#${hue.base07-hex}";
                    fadeAmount = 0;
                    fadeColor = "#${hue.base00-hex}";
                };
                name = "stylix";
                qssFilePath = "themeStyle.css";
                widgets = "Fusion";
            };

            home.file.".local/share/PrismLauncher/themes/themeStyle.ccs".text = ''
                QToolTip {
                    color: #${hue.base07-hex};
                    background-color: #${hue.base0D-hex};
                    border: 1px solid #${hue.base07-hex};
                }
            '';
        };
    };
}
