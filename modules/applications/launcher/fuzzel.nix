{ username, config, lib, pkgs, ... }:

{
    options.launcher.fuzzel.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable my fuzzel module";
    };

    config = lib.mkIf config.launcher.fuzzel.enable {
        launcher.package = pkgs.fuzzel;
        launcher.command = "fuzzel";
        home-manager.users.${username} = {
            programs.fuzzel = {
                enable = true;
                settings = {
                    main = {
                        terminal = "${config.terminal.openWindow}";
                        layer = "overlay";
                    };
                    border.width = 4;
                };
            };
        };
    };
}
