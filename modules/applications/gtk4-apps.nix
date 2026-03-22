{ pkgs, lib, config, ... }:

{
    options.mySystem.applications.gtk-apps.enable = lib.mkEnableOption "gtk-apps";

    config = lib.mkIf config.mySystem.applications.gtk-apps.enable {
        environment.systemPackages = with pkgs; [
            baobab
            totem
            constrict
            curtail
            deluge
            pinta
            blanket
            resources
            video-trimmer
            loupe
        ];

        xdg.mime.defaultApplications = {
            "video/mp4" = "org.gnome.Totem.desktop";
            "video/mkv" = "org.gnome.Totem.desktop";
            "video/webm" = "org.gnome.Totem.desktop";
            "video/x-matroska" = "org.gnome.Totem.desktop";
        };
    };
}
