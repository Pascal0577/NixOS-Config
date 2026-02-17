{ pkgs, username, lib, config, ... }:
let
    yaziChooser = pkgs.writeShellScript "yazi-chooser" ''
        multiple="$1"
        directory="$2"
        save="$3"
        path="$4"
        out="$5"

        if [ "$save" = "1" ]; then
            set -- --chooser-file="$out" "$path"
        elif [ "$directory" = "1" ]; then
            set -- --chooser-file="$out" --cwd-file="$out.1" "$path"
        elif [ "$multiple" = "1" ]; then
            set -- --chooser-file="$out" "$path"
        else
            set -- --chooser-file="$out" "$path"
        fi

        ${lib.getExe pkgs.foot} --app-id=my.file-chooser -e ${lib.getExe pkgs.yazi} "$@"

        if [ "$directory" = "1" ]; then
            if [ ! -s "$out" ] && [ -s "$out.1" ]; then
                cat "$out.1" > "$out"
                rm "$out.1"
            else
                rm -f "$out.1"
            fi
        fi
    '';
in
{
    options.mySystem.applications.file-manager.yazi.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable my Yazi module";
    };

    config = lib.mkIf config.mySystem.applications.file-manager.yazi.enable {
        mySystem.applications.file-manager.package = pkgs.yazi;
        programs.yazi.enable = true;

        xdg.portal = {
            enable = true;
            extraPortals = with pkgs; [
                xdg-desktop-portal-termfilechooser
                xdg-desktop-portal-gnome
            ];
            config.common = {
                default = [ "gnome" ];
                "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
            };
        };

        home-manager.users.${username} = {
            programs.foot.enable = true;
            home.file.".config/xdg-desktop-portal-termfilechooser/config".text = ''
                [filechooser]
                cmd=${yaziChooser}
                default_dir=$HOME
                open_mode=suggested
                save_mode=last
            '';
        };
    };
}
