{ username, config, ... }:

{
    launcherCommand = "fuzzel";
    home-manager.users.${username} = {
        programs.fuzzel = {
            enable = true;
            settings = {
                main = {
                    terminal = "${config.terminalOpenWindow}";
                    layer = "overlay";
                };
                border.width = 4;
            };
        };
    };
}
