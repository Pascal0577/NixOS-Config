{
    imports = [ ./nvidia.nix ];
    
    mySystem = {
        theme.everforest.enable = true;
        impermanence.enable = true;
        ZFS.enable = true;
        desktop.niri = {
            enable = true;
            unstable = true;
        };
        applications = {
            obs.nvidia = true;
            helix.enable = true;
            launcher.vicinae.enable = true;
            terminal.emulator = "foot";
            file-manager.nautilus.enable = true;
        };
    };
}
