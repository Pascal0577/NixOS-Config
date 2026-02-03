{ pkgs, username, ... }:
{
    environment.systemPackages = with pkgs; [ 
        nautilus
        unzip
        cabextract
    ];

    services.gvfs.enable = true;

    programs.nautilus-open-any-terminal = {
        enable = true;
    };

    home-manager.users.${username} = {
        dconf.settings."org/gnome/nautilus/preferences" = {
            click-policy = "single";
            show-create-link = true;
            show-delete-permanently = true;
        };
    };
}
