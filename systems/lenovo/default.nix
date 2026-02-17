{ pkgs, lib, config, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules
        ../../modules/themes/everforest.nix
    ];

    mySystem = {
        applications.terminal.foot.enable = true;
        desktop.niri.enable = true;
        desktop.cosmic = {
            enable = true;
            accentColor = "${config.lib.stylix.colors.base09-hex}";
            accentRed = "${config.lib.stylix.colors.base09-dec-r}";
            accentGreen = "${config.lib.stylix.colors.base09-dec-g}";
            accentBlue = "${config.lib.stylix.colors.base09-dec-b}";
            cosmicOnNiri.enable = true;
        };
    };

    programs.niri.package = lib.mkForce pkgs.niri-stable;
}
