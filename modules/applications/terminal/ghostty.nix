{ username, lib, config, ... }:

{
    config = lib.mkIf (config.mySystem.applications.terminal.choice == "ghostty") {
        mySystem.applications.terminal = {
            runCommand = "ghostty -e";
            openWindow = "ghostty +new-window";
        };

        home-manager.users.${username} = {
            stylix.targets.ghostty.enable = true;
            programs.ghostty = {
                enable = true;
                enableZshIntegration = true;
                systemd.enable = true;
                settings = {
                    confirm-close-surface = false;
                    quit-after-last-window-closed = true;
                    quit-after-last-window-closed-delay = "1h";
                    clipboard-paste-protection = false;
                };
            };
        };
    };
}
