{ pkgs, username, lib, config, ... }:
let
    nvim = config.mySystem.applications.neovim;
    niri = config.mySystem.desktop.niri;
    hue = config.lib.stylix.colors;
in
{
    options.mySystem.theme.tokyonight.enable = lib.mkEnableOption "Tokyo Night theme";

    config = lib.mkIf config.mySystem.theme.tokyonight.enable {
        stylix = {
            base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-moon.yaml";
            image = ../../assets/tokyonight_original.png;
        };

        home-manager.users.${username} = lib.mkMerge [
            (lib.mkIf nvim.enable {
                programs.nixvim = {
                    colorschemes.tokyonight = {
                        enable = true;
                        settings.style = "moon";
                    };

                    performance.combinePlugins.standalonePlugins = [
                        pkgs.vimPlugins.tokyonight-nvim
                    ];
                };
            })

            (lib.mkIf niri.enable {
                programs.niri.settings.layout.border.active.color = "#${hue.base08-hex}";
            })
        ];
    };
}
