{ pkgs, lib, config, ... }:

{
    options = {
        terminalPackage = lib.mkOption {
            type = lib.types.package;
            default = pkgs.ghostty;
            description = "Terminal package";
        };

        terminalOpenWindow = lib.mkOption {
            type = lib.types.str;
            default = "ghostty +new-window";
            description = "Command used to open a new terminal window";
        };

        terminalRunCommand = lib.mkOption {
            type = lib.types.str;
            default = "${config.terminalOpenWindow} -e";
            description = "Command used to run a command in a new terminal window";
        };
    };
}
