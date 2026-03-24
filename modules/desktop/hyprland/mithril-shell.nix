{ pkgs, username, inputs, config, lib, ... }:
let
    hypr = config.mySystem.desktop.hyprland;
in
{
    options.mySystem.desktop.hyprland.mithril-shell.enable =
        lib.mkEnableOption "Mithril Shell for Hyprland";

    config = lib.mkIf (hypr.mithril-shell.enable && hypr.enable) {
        home-manager.users.${username} = {
            imports = [ inputs.mithril-shell.homeManagerModules.default ];

            services.swaync.enable = true;

            services.mithril-shell = {
                enable = true;
                integrations.hyprland.enable = true;
            };
        };
    };
}
