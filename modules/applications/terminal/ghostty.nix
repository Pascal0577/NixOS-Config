{ username, ... }:

{
    terminalRunCommand = "ghostty -e";
    terminalOpenWindow = "ghostty +new-window";
    home-manager.users.${username} = {
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
}
