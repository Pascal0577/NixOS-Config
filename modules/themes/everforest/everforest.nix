{ pkgs, username, lib, config, ... }:
let
    nvim = config.mySystem.applications.neovim;
    hue = config.lib.stylix.colors;
in
{
    config = lib.mkIf (config.mySystem.theme == "everforest") {
        mySystem.desktop.niri.borderColor = "${hue.base09}";
        stylix = {
            base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-soft.yaml";
            image = ./flowers.png;
        };

        home-manager.users.${username} = lib.mkMerge [
            {
                programs.fuzzel.settings.colors.border = lib.mkForce "${hue.base09-hex}ff";
            }

            (lib.mkIf (!config.mySystem.server.enable) {
                dconf.settings."org/gnome/desktop/interface".accent-color = "slate";                
            })

            (lib.mkIf nvim.enable {
                programs.nixvim = {
                    colorschemes.everforest = {
                        enable = true;
                        settings.background = "soft";
                    };

                    performance.combinePlugins.standalonePlugins = [
                        pkgs.vimPlugins.everforest
                    ];
                };
            })
        ];
    };
}
