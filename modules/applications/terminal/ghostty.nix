{ pkgs, username, lib, config, ... }:

{
    options.terminal.ghostty.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable my Ghostty module";
    };

    config = lib.mkIf config.terminal.ghostty.enable {
        terminal.package = pkgs.ghostty;
        terminal.runCommand = "ghostty -e";
        terminal.openWindow = "ghostty +new-window";
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
    };
}
