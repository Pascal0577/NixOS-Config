{ lib, username, config, ... }:
let
    hue = config.lib.stylix.colors;
in
{
    options.desktop.oxwm.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable my OXWM module";
    };

    config = lib.mkIf config.desktop.oxwm.enable {
        services = {
            displayManager.ly.enable = true;
            xserver = {
                enable = lib.mkForce true;
                windowManager.oxwm.enable = true;
            };
        };

        home-manager.users.${username} = {
            home.file = {
                ".config/oxwm/colors.lua".text = ''
                    colors = {
                        fg = "#${hue.base05-hex}",
                        bg = "#${hue.base00-hex}",
                        red = "#${hue.base08-hex}",
                        orange = "#${hue.base09-hex}",
                        yellow = "#${hue.base0A-hex}",
                        green = "#${hue.base0B-hex}",
                        cyan = "#${hue.base0C-hex}",
                        blue = "#${hue.base0D-hex}",
                        purple = "#${hue.base0E-hex}",
                        brown = "#${hue.base0F-hex}",
                    }
                '';

                ".config/oxwm/launcher.lua".text = ''
                    oxwm.key.bind({ "Mod4" }, "D", oxwm.spawn({ "sh", "-c", "${config.launcherCommand}" }))
                '';

                ".config/oxwm/terminal.lua".text = ''
                    terminal = "${config.terminal.openWindow}"
                '';
            };
        };
    };
}
