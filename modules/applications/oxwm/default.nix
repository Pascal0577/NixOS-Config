{ lib, username, config, ... }:

{
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
                    fg = "#${config.lib.stylix.colors.base05-hex}",
                    bg = "#${config.lib.stylix.colors.base00-hex}",
                    red = "#${config.lib.stylix.colors.base08-hex}",
                    orange = "#${config.lib.stylix.colors.base09-hex}",
                    yellow = "#${config.lib.stylix.colors.base0A-hex}",
                    green = "#${config.lib.stylix.colors.base0B-hex}",
                    cyan = "#${config.lib.stylix.colors.base0C-hex}",
                    blue = "#${config.lib.stylix.colors.base0D-hex}",
                    purple = "#${config.lib.stylix.colors.base0E-hex}",
                    brown = "#${config.lib.stylix.colors.base0F-hex}",
                }
            '';

            ".config/oxwm/launcher.lua".text = ''
                oxwm.key.bind({ "Mod4" }, "D", oxwm.spawn({ "sh", "-c", "${config.launcherCommand}" }))
            '';

            ".config/oxwm/terminal.lua".text = ''
                terminal = "${config.terminalOpenWindow}"
            '';
        };
    };
}
