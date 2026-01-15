{ pkgs, username, ... }:
{
    environment.systemPackages = [ pkgs.nautilus ];
    services.gvfs.enable = true;
    programs.niri.useNautilus = true;

    programs.nautilus-open-any-terminal = {
        enable = true;
        terminal = "ghostty";
    };

    home-manager.users.${username} = {
        dconf.settings."org/gnome/nautilus/preferences" = {
            click-policy = "single";
            show-create-link = true;
            show-delete-permanently = true;
        };
    };
}
