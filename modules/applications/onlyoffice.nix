{ config, lib, username, ... }:
let
    hmDir = config.home-manager.users.home.homeDirectory;
in
{
    options.mySystem.applications.onlyoffice.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable my OnlyOffice module";
    };

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
