{ pkgs, username, ... }:

{
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
}
