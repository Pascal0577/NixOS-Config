{ pkgs, username, lib, config, ... }:

{
    options.file-manager.nautilus.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable my Nautilus module";
    };

    config = lib.mkIf config.file-manager.nautilus.enable {
        environment.systemPackages = with pkgs; [ 
            nautilus
            unzip
            cabextract
        ];

        programs.nautilus-open-any-terminal.enable = true;
        services.gvfs.enable = true;

        home-manager.users.${username} = {
            dconf.settings."org/gnome/nautilus/preferences" = {
                click-policy = "single";
                show-create-link = true;
                show-delete-permanently = true;
            };
        };
    };
}
