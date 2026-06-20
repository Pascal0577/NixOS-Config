{ lib, config, ... }:

{
    options.mySystem.applications.terminal = {
        emulator = lib.mkOption {
            type = lib.types.enum [ "foot"  "ghostty" "kitty" ];
            default = "foot";
        };

        openWindow = lib.mkOption {
            type = lib.types.str;
            default = "ghostty +new-window";
            description = "Command used to open a new terminal window";
        };

        runCommand = lib.mkOption {
            type = lib.types.str;
            default = "${config.mySystem.applications.terminal.openWindow} -e";
            description = "Command used to run a command in a new terminal window";
        };
    };
}
