{ pkgs, config, lib, username, ... }:

{
    config = lib.mkIf (config.mySystem.applications.terminal.choice == "foot") {
        mySystem.applications.terminal.openWindow = "${lib.getExe pkgs.foot}";

        home-manager.users.${username} = {
            stylix.targets.foot.enable = true;
            programs.foot = {
                enable = true;
                server.enable = true;
                settings.cursor = {
                    style = "beam";
                    blink = true;
                };
            };
        };
    };
}
