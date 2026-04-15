{ username, lib, config, ... }:
let
    niri = config.mySystem.desktop.niri;
    hue = config.lib.stylix.colors;
in
{
    options.mySystem.theme.sekiro.enable = lib.mkEnableOption "sekiro theme";

    config = lib.mkIf config.mySystem.theme.sekiro.enable {
        stylix = {
            # base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-soft.yaml";
            image = ../../assets/sekiro.jpg;
        };

        home-manager.users.${username} = lib.mkMerge [
            # {
            #     programs.fuzzel.settings.colors.border = lib.mkForce "${hue.base09-hex}ff";
            # }

            (lib.mkIf niri.enable {
                programs.niri.settings.layout.border.active.color = "#${hue.base09-hex}";
            })
        ];
    };
}
