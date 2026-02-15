{ inputs, config, lib, username, cosmicLib, ... }:

{
    options.desktop.cosmic.applibrary.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable the COSMIC app library widget thing";
    };

    config.home-manager.users.${username} = lib.mkIf config.desktop.cosmic.applibrary.enable {
        imports = [ inputs.cosmic-manager.homeManagerModules.cosmic-manager ];

        programs.cosmic-applibrary = {
            enable = true;
            settings = {
                groups = [
                    {
                        filter = cosmicLib.mkRON "namedStruct" {
                            name = "Categories";
                            value = {
                                categories = [
                                    "Office"
                                ];
                                exclude = [ ];
                                include = [
                                    "org.gnome.Totem"
                                    "org.gnome.eog"
                                    "simple-scan"
                                    "thunderbird"
                                ];
                            };
                        };
                        icon = "folder-symbolic";
                        name = "cosmic-office";
                    }
                    {
                        filter = cosmicLib.mkRON "enum" {
                            value = [
                                "Counter-Strike 2"
                            ];
                            variant = "AppIds";
                        };
                        icon = "folder-symbolic";
                        name = "Games";
                    }
                ];
            };
        };
    };
}
