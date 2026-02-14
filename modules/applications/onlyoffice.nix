{ config, lib, username, ... }:

{
    options.applications.onlyoffice.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable my OnlyOffice module";
    };

    config = lib.mkIf config.applications.onlyoffice.enable {
        home-manager.users.${username}.programs.onlyoffice = {
            enable = true;
            settings = {
                UITheme = "theme-night";
                openPath = "/home/pascal/Documents";
                savePath = "/home/pascal/Documents";
                titlebar = "custom";
                editorWindowMode = false;
            };
        };
    };
}
