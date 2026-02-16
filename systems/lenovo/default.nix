{ pkgs, lib, config, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules
        ../../modules/themes/everforest.nix
    ];

    terminal.alacritty.enable = true;
    launcher.fuzzel.enable = true;
    file-manager.yazi.enable = true;
    desktop.niri.enable = true;
    desktop.cosmic = {
        enable = true;
        accentRed = "${config.lib.stylix.colors.base09-dec-r}";
        accentGreen = "${config.lib.stylix.colors.base09-dec-g}";
        accentBlue = "${config.lib.stylix.colors.base09-dec-b}";
    };

    programs.niri.package = lib.mkForce pkgs.niri-stable;
}
