{ lib, config, ... }:

{
    options.mySystem.applications.terminal = {
        choice = lib.mkOption {
            type = lib.types.enum [ "foot"  "ghostty" "kitty" "none" ];
            default = "none";
        };

        desktopFile = lib.mkOption {
            type = lib.types.str;
            default = "${config.mySystem.applications.terminal.choice}.desktop";
        };

        openWindow = lib.mkOption {
            type = lib.types.str;
            default = "${config.mySystem.applications.terminal.choice}";
            description = "Command used to open a new terminal window";
        };

        runCommand = lib.mkOption {
            type = lib.types.str;
            default = "${config.mySystem.applications.terminal.openWindow} -e";
            description = "Command used to run a command in a new terminal window";
        };
    };

    config = lib.mkIf (config.mySystem.applications.terminal.choice != "none") {
        xdg.mime.defaultApplications."x-scheme-handler/terminal" = "footclient.desktop";
        xdg.terminal-exec = {
            enable = true;
            settings.default = [ config.mySystem.applications.terminal.desktopFile ];
        };
    };
}
