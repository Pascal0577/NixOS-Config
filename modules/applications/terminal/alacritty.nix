{ pkgs, username, lib, config, ... }:

{
    options.terminal.alacritty.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable my Alacritty module";
    };

    config = lib.mkIf config.terminal.alacritty.enable {
        terminal.package = pkgs.alacritty;
        terminal.openWindow = "alacritty";
        home-manager.users.${username} = {
            programs.alacritty = {
                enable = true;
                settings.cursor = {
                    blink_timeout = 0;
                    style = {
                        shape = "Beam";
                        blinking = "On";
                    };
                };
            };
        };
    };
}
