{ username, ... }:

{
    terminalOpenWindow = "alacritty";
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
}
