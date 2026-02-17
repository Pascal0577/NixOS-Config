{ pkgs, username, lib, config, ... }:

{
    options.mySystem.applications.terminal.alacritty.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable my Alacritty module";
    };

    config = lib.mkIf config.mySystem.applications.terminal.alacritty.enable {
        mySystem.applications.terminal = {
            package = pkgs.alacritty;
            openWindow = "alacritty";
        };

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
