{ username, pkgs, config, lib, ... }:
let
    gnomeChoice = (config.mySystem.desktop.choice == "gnome");
in
{
    options.mySystem.desktop.gnome.dashToDock =
        lib.mkEnableOption "Dash to Dock extension for GNOME";

    config = lib.mkIf (config.mySystem.desktop.gnome.dashToDock && gnomeChoice) {
        environment.systemPackages = [ pkgs.gnomeExtensions.dash-to-dock ];

        home-manager.users.${username} = {
            dconf.settings = {
                "org/gnome/shell".enabled-extensions = [ pkgs.gnomeExtensions.dash-to-dock.extensionUuid ];

                "org/gnome/shell/extensions/dash-to-dock" = {
                    dock-position = "RIGHT";
                    intellihide-mode = "MAXIMIZED_WINDOWS";
                    transparency-mode = "FIXED";
                    running-indicator-style = "DOT";
                    custom-theme-shrink = true;
                    customize-alphas = true;
                    height-fraction = 0.9;
                    extend-height = true;
                    dock-fixed = false;
                    max-alpha = 1.0;
                    min-alpha = 1.0;
                };
            };
        };
    };
}
