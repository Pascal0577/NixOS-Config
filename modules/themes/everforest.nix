{ pkgs, username, lib, config, ... }:
let
    nvim = config.mySystem.applications.neovim;
    niri = config.mySystem.desktop.niri;
    hue = config.lib.stylix.colors;
in
{
    options.mySystem.theme.everforest.enable = lib.mkEnableOption "everforest theme";

    config = lib.mkIf config.mySystem.theme.everforest.enable {
        stylix = {
            base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-soft.yaml";
            image = ../../assets/flowers.png;

            cursor = {
                package = pkgs.everforest-cursors;
                name = "everforest-cursors";
                size = 32;
            };
        };

        home-manager.users.${username} = lib.mkIf nvim.enable {
            programs.nixvim = {
                colorschemes.everforest = {
                    enable = true;
                    settings.background = "soft";
                };

                performance.combinePlugins.standalonePlugins = [
                    pkgs.vimPlugins.everforest
                ];
            };

            programs.niri.settings.layout.border.active.color =
                lib.mkIf niri.enable "#${hue.base09-hex}";
        };
    };
}
