{ lib, config, pkgs, username, ... }: 
let
    cosmicCfg = config.mySystem.desktop.cosmic;
in
{
    options.mySystem.desktop.cosmic.cosmicOnNiri.enable = lib.mkEnableOption "cosmicOnNiri";

    config = lib.mkIf (cosmicCfg.cosmicOnNiri.enable && cosmicCfg.enable) {
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

        mySystem.applications.launcher = {
            command = "cosmic-launcher";
            package = pkgs.cosmic-launcher;
        };

        home-manager.users.${username} = {
            stylix.targets.gtk.enable = false;
            programs.niri.settings = {
                spawn-at-startup = [{argv = ["cosmic-ext-alternative-startup" ];}];
                layout.border.active.color = lib.mkForce "#${cosmicCfg.accentColor}";
            };
        };
    };
}
