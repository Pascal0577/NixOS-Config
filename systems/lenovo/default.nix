{ lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ] ++ lib.filesystem.listFilesRecursive ../../modules;

    mySystem = {
        theme.everforest.enable = true;
        applications.helix.enable = true;
        applications.terminal.foot.enable = true;
        applications.launcher.vicinae.enable = true;
        applications.file-manager.yazi.enable = true;
        applications.heroic.enable = false;
        desktop.niri.enable = true;
    };

    nix.settings.substituters = [ "ssh://pascal@161.6.195.206" ];

    stylix.targets.plymouth.enable = lib.mkForce true;
}
