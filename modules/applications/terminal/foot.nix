{ pkgs, config, lib, username, ... }:

{
    options.terminal.foot.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable foot terminal";
    };

    config = lib.mkIf config.terminal.foot.enable {
        terminal.package = pkgs.foot;
        terminal.openWindow = "${lib.getExe pkgs.foot}";
        home-manager.users.${username} = {
            programs.foot = {
                enable = true;
                server.enable = true;
            };
        };
    };
}
