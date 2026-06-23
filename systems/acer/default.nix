{
    imports = [ ./nvidia.nix ];

    mySystem = {
        desktop.choice = "niri";
        theme = "everforest";
        impermanence.enable = true;
        ZFS.enable = true;
        power-management.enable = false;
        applications = {
            launcher.choice = "vicinae";
            terminal.choice = "foot";
            file-manager.choice = "nautilus";
            obs.nvidia = true;
            helix.enable = true;
            tuned.enable = true;
        };
    };
}
