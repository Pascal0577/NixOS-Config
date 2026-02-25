{ pkgs, username, config, lib, ... }:
let
    nvim = config.mySystem.applications.neovim;
in
{
    options.mySystem.theme.nord.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
    };

    config = lib.mkIf config.mySystem.theme.nord.enable {
        stylix = {
            base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
            image = ../../assets/nord-arctic-fox.png;
            icons.package = pkgs.papirus-nord;
        };

        home-manager.users.${username} = {
            stylix.targets.ghostty.enable = false;
            programs = {
                ghostty.settings.theme = "Nord";
                vesktop.vencord.settings.enabledThemes = [ "nordic.vencord.css" ];
                nixvim = lib.mkIf nvim.enable {
                    colorschemes.nord = {
                        enable = true;
                        settings = {
                            borders = true;
                            contrast = true;
                        };
                    };

                    performance.combinePlugins.standalonePlugins = [
                        pkgs.vimPlugins.nord-nvim
                    ];
                };
            };
        };
    };
}
