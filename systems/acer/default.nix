{ pkgs, lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./impermanence.nix
    ] ++ lib.filesystem.listFilesRecursive ../../modules;

    mySystem = {
        theme.everforest.enable = true;
        impermanence.enable = true;
        ZFS.enable = true;
        desktop.niri = {
            enable = true;
            unstable = true;
        };
        applications = {
            obs.enable = false;
            helix.enable = true;
            swayidle.enable = false;
            launcher.vicinae.enable = true;
            terminal.foot.enable = true;
            file-manager.yazi.enable = true;
        };
    };

    environment.systemPackages = with pkgs; [
        playerctl
        lmstudio
    ];
}
