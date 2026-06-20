{
    imports = [ ./nvidia.nix ];
    
    mySystem = {
        theme = "everforest";
        impermanence.enable = true;
        ZFS.enable = true;
        desktop = "niri";
        applications = {
            obs.nvidia = true;
            helix.enable = true;
            launcher.choice = "vicinae";
            terminal.emulator = "foot";
            file-manager.nautilus.enable = true;
        };
    };
}
