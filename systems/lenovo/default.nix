{ lib, config, username, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ] ++ lib.filesystem.listFilesRecursive ../../modules;

    mySystem = {
        theme.everforest.enable = true;
        applications.gtk4-apps.enable = true;
        applications.helix.enable = true;
        applications.terminal.alacritty.enable = true;
        applications.launcher.vicinae.enable = true;
        applications.file-manager.nautilus.enable = true;
        applications.heroic.enable = false;
        desktop = {
            oxwm.enable = false;
            hyprland = {
                enable = true;
                mithril-shell.enable = true;
            };
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

    stylix.targets.plymouth.enable = lib.mkForce true;
    services.displayManager = {
        ly.enable = true;
        autoLogin = {
            user = "${username}";
            enable = true;
        };
    };
}
