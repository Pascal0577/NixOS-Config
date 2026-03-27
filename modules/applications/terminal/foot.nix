{ pkgs, config, lib, username, ... }:

{
    options.mySystem.applications.terminal.foot.enable =
        lib.mkEnableOption "Foot terminal module";

    config = lib.mkIf config.mySystem.applications.terminal.foot.enable {
        mySystem.applications.terminal = {
            package = pkgs.foot;
            openWindow = "${lib.getExe pkgs.foot}";
        };

        xdg.mime.defaultApplications = {
            "x-scheme-handler/terminal" = "foot.desktop";
        };

        home-manager.users.${username} = {
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
