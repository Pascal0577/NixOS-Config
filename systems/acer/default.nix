{
    imports = [ ./nvidia.nix ];

    mySystem = {
        desktop.choice = "niri";
        theme = "gruvbox";
        impermanence.enable = true;
        ZFS.enable = true;
        power-management.enable = false;
        applications = {
            launcher.choice = "vicinae";
            terminal.choice = "foot";
            file-manager.choice = "nautilus";
            obs.nvidia = true;
            helix.enable = true;
        };
    };
}
