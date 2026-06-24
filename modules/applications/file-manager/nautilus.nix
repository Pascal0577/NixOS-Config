{ pkgs, username, lib, config, ... }:

{
    config = lib.mkIf (config.mySystem.applications.file-manager.choice == "nautilus") {
        environment.systemPackages = with pkgs; [ 
            nautilus
            ffmpegthumbnailer
            unzip
            cabextract
        ];

        services.gvfs.enable = true;

        programs.nautilus-open-any-terminal = {
            enable = true;
            terminal = config.mySystem.applications.terminal.choice;
        };

        xdg.mime.defaultApplications = {
            "inode/directory" = "org.gnome.Nautilus.desktop";
        };

        home-manager.users.${username} = {
            dconf.settings."org/gnome/nautilus/preferences" = {
                click-policy = "single";
                show-create-link = true;
                show-delete-permanently = true;
            };
        };
    };
}
