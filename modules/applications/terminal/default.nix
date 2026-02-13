{ pkgs, lib, config, ... }:

{
    options.terminal = {
        package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.ghostty;
            description = "Terminal package";
        };

        openWindow = lib.mkOption {
            type = lib.types.str;
            default = "ghostty +new-window";
            description = "Command used to open a new terminal window";
        };

        runCommand = lib.mkOption {
            type = lib.types.str;
            default = "${config.terminal.openWindow} -e";
            description = "Command used to run a command in a new terminal window";
        };
    };

    imports = [
        ./alacritty.nix
        ./ghostty.nix
        ./kitty.nix
    ];
}
