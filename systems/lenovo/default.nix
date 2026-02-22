{ pkgs, lib, config, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ] ++ lib.filesystem.listFilesRecursive ../../modules;

    mySystem = {
        applications.terminal.alacritty.enable = true;
        applications.launcher.dmenu.enable = true;
        desktop = {
            oxwm.enable = true;
            niri = {
                enable = false;
                stable = true;
            };
            cosmic = {
                enable = false;
                accentColor = "${config.lib.stylix.colors.base09-hex}";
                accentRed = "${config.lib.stylix.colors.base09-dec-r}";
                accentGreen = "${config.lib.stylix.colors.base09-dec-g}";
                accentBlue = "${config.lib.stylix.colors.base09-dec-b}";
                cosmicOnNiri.enable = false;
            };
        };
    };

    services.displayManager.ly.enable = true;
}
