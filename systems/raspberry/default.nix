{ lib, config, ... }:

{
    imports = [
        ./hardware-configuration.nix        
    ] ++ lib.filesystem.listFilesRecursive ../../modules/;

    mySystem = {
        applications = {
            theme.everforest.enable = true;
            zsh.enable = true;
            appimage.enable = false;
            discord.enable = false;
            fastfetch.enable = true;
            git.enable = true;
            heroic.enable = false;
            kmscon.enable = true;
            mathematica.enable = false;
            mullvad.enable = false;
            noctalia.enable = false;
            obs.enable = false;
            onlyoffice.enable = false;
            pipewire.enable = false;
            prismauncher.enable = false;
            ssh.enable = true;
            swayidle.enable = false;
            virt-manager.enable = false;
            zen-browser.enable = false;
            boot.enableSecureBoot = false;
            boot.enablePlymouth = false;
        };
    };
}
