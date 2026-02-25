{ pkgs, username, lib, config, ... }:
let
    nvim = config.mySystem.applications.neovim;
in
{
    options.mySystem.theme.tokyonight.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
    };

    config = lib.mkIf config.mySystem.theme.tokyonight.enable {
        stylix = {
            base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-moon.yaml";
            image = ../../assets/tokyonight_original.png;
        };

        home-manager.users.${username} = {
            programs.nixvim = lib.mkIf nvim.enable {
                colorschemes.tokyonight = {
                    enable = true;
                    settings.style = "moon";
                };

                performance.combinePlugins.standalonePlugins = [
                    pkgs.vimPlugins.tokyonight-nvim
                ];
            };
        };
    };
}
