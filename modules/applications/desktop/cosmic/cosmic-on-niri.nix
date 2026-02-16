{ lib, config, pkgs, username, ... }: 

{
    options.desktop.cosmic.cosmicOnNiri.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable the Niri compositor for the COSMIC session";
    };

    config = lib.mkIf config.desktop.cosmic.cosmicOnNiri.enable {
        environment = {
            systemPackages = [
                (pkgs.callPackage ../../../../packages/cosmic-ext-niri/default.nix {})
                pkgs.adw-gtk3
            ];
            pathsToLink = [ "/share/wayland-sessions" ];
        };

        xdg.portal = {
            enable = true;
            extraPortals = with pkgs; [
                xdg-desktop-portal-cosmic
                xdg-desktop-portal-gnome
                xdg-desktop-portal-gtk
            ];
            config = {
                niri = {
                    default = [ "gnome" "gtk" ];
                    "org.freedesktop.impl.portal.FileChooser" = [ "gnome" ];
                    "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
                    "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
                };
                cosmic = {
                    default = [ "cosmic" "gtk" ];
                };
            };
        };

        launcher = {
            command = "cosmic-launcher";
            package = pkgs.cosmic-launcher;
        };

        home-manager.users.${username} = {
            programs.niri.settings.layout.border = {
                active.color = lib.mkForce "#${config.desktop.cosmic.accentColor}";
            };
            stylix.targets.gtk.enable = false;
        };
    };
}
