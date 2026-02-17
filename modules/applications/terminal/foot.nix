{ pkgs, config, lib, username, ... }:

{
    options.mySystem.applications.terminal.foot.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable foot terminal";
    };

    config = lib.mkIf config.mySystem.applications.terminal.foot.enable {
        mySystem.applications.terminal = {
            package = pkgs.foot;
            openWindow = "${lib.getExe pkgs.foot}";
        };

        home-manager.users.${username} = {
            programs.foot = {
                enable = true;
                server.enable = true;
            };
        };
    };
}
