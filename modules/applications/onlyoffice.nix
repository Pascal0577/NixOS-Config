{ config, lib, username, ... }:
let
    hmDir = config.home-manager.users.${username}.home.homeDirectory;
in
{
    options.mySystem.applications.onlyoffice.enable =
        lib.mkEnableOption "OnlyOffice module (requires xwayland)"
        // { default = !config.mySystem.server.enable; };

    config = lib.mkIf config.mySystem.applications.onlyoffice.enable {
        home-manager.users.${username}.programs.onlyoffice = {
            enable = true;
            settings = {
                UITheme = "theme-night";
                openPath = "${hmDir}/Documents";
                savePath = "${hmDir}/Documents";
                titlebar = "custom";
                editorWindowMode = false;
            };
        };
    };
}
