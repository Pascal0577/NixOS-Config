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
            opacity.terminal = 1.0;
            opacity.popups = 1.0;
            opacity.desktop = 1.0;
            opacity.applications = 1.0;

            cursor = {
                package = pkgs.callPackage ../../packages/google-dot-cursors {};
                name = "GoogleDot-Everforest";
                size = 32;
            };
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

            (lib.mkIf niri.enable {
                programs.niri.settings.layout.border.active.color = "#${hue.base09-hex}";
            })
        ];
    };
}
