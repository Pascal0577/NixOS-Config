{ inputs, pkgs, username, lib, config, ... }:

{
    options.mySystem.theme.tokyonight.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
    };

    imports = [ inputs.stylix.nixosModules.stylix ];

    config = lib.mkIf config.mySystem.theme.tokyonight.enable {
        stylix = {
            base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-moon.yaml";
            image = ../../assets/tokyonight_original.png;
        };

        home-manager.users.${username} = {
            programs.nixvim = {
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
