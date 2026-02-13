{ config, lib, pkgs, ... }:

{
    options.terminal.kitty.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable Kitty module";
    };

    config = lib.mkIf config.terminal.kitty.enable {
        terminal = {
            package = pkgs.kitty;
            openWindow = "kitty";
            runCommand = "kitty -e";
        };

        environment.systemPackages = [ pkgs.kitty ];
    };
}
