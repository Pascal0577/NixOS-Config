{ config, lib, pkgs, username, ... }:

{
    options.mySystem.applications.terminal.kitty.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable Kitty module";
    };

    config = lib.mkIf config.mySystem.applications.terminal.kitty.enable {
        mySystem.applications.terminal = {
            package = pkgs.kitty;
            openWindow = "kitty";
            runCommand = "kitty -e";
        };

        home-manager.users.${username} = {
            programs.kitty.enable = true;
        };
    };
}
