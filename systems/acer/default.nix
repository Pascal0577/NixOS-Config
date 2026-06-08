{
    imports = [ ./nvidia.nix ];
    
    mySystem = {
        theme.everforest.enable = true;
        impermanence.enable = true;
        ZFS.enable = true;
        desktop.niri = {
            enable = true;
            unstable = false;
        };
        applications = {
            obs.nvidia = true;
            helix.enable = true;
            launcher.vicinae.enable = true;
            terminal.foot.enable = true;
            file-manager.nautilus.enable = true;
        };
    };
}
