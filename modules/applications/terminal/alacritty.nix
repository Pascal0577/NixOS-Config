{ pkgs, username, lib, config, ... }:

{
    options.mySystem.applications.terminal.alacritty.enable =
        lib.mkEnableOption "Alacritty terminal module";

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
