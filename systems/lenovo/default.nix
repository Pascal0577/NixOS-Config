{ lib, config, username, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ] ++ lib.filesystem.listFilesRecursive ../../modules;

    mySystem = {
        theme.everforest.enable = true;
        applications.neovim.enable = false;
        applications.gtk4-apps.enable = true;
        applications.helix.enable = true;
        applications.terminal.alacritty.enable = true;
        applications.launcher.vicinae.enable = true;
        applications.file-manager.nautilus.enable = true;
        applications.noctalia.enable = true;
        applications.heroic.enable = false;
        boot.enableZfs = false;
        desktop.niri = {
            enable = true;
            stable = true;
        };
    };

    stylix.targets.plymouth.enable = lib.mkForce true;
    networking.hostId = "4e98920d";
    services.displayManager.ly.enable = true;
}
