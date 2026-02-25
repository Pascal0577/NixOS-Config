{ pkgs, username, lib, config, ... }:
let
    nvim = config.mySystem.applications.neovim;
in
{
    options.mySystem.theme.everforest.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;  
    };

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
        };
    };
}
