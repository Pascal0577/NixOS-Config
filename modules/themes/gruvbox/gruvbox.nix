{ pkgs, username, lib, config, ... }:

{
    config = lib.mkIf (config.mySystem.theme == "gruvbox") {
        stylix = {
            image = ./sunlight.png;
            base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-soft.yaml";
            polarity = "dark";
            opacity.terminal = 0.85;
            opacity.applications = 0.85;
            opacity.desktop = 0.85;
            opacity.popups = 0.85;
        };

        home-manager.users.${username} = lib.mkMerge [
            (lib.mkIf (!config.mySystem.server.enable) {
                dconf.settings."org/gnome/desktop/interface".accent-color = "orange";
            })

            (lib.mkIf config.mySystem.applications.neovim.enable {
                programs.nixvim = {
                    colorschemes.gruvbox-material = {
                        enable = true;
                        settings = {
                            background = "soft";
                            transparent_background = 1;
                            diagnostic_text_highlight = 1;
                        };
                    };

                    performance.combinePlugins.standalonePlugins = [
                        pkgs.vimPlugins.gruvbox-material
                    ];
                };
            })
        ];
    };
}
