{ username, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        gnomeExtensions.dash-to-dock
    ];

    home-manager.users.${username} = {
        dconf.settings = {
            "org/gnome/shell" = {
                enabled-extensions = with pkgs.gnomeExtensions; [
                    dash-to-dock.extensionUuid
                ];
            };

            "org/gnome/shell/extensions/dash-to-dock" = {
                dock-position = "RIGHT";
                intellihide-mode = "MAXIMIZED_WINDOWS";
                transparency-mode = "DYNAMIC";
                running-indicator-style = "DOT";
                custom-theme-shrink = true;
                customize-alphas = true;
                height-fraction = 0.9;
                extend-height = true;
                dock-fixed = false;
                max-alpha = 1.0;
                min-alpha = 0.0;
            };
        };
    };
}
