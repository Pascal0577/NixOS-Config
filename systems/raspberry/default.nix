{ lib, config, inputs,... }:

{
    # Exclude the niri module because for some reason including the flake's
    # nixos module forces a build a niri
    imports = [
        ./hardware-configuration.nix
    ] ++ (lib.filter 
        (f: !(lib.hasSuffix "desktop/niri/default.nix" (toString f)))
        (lib.filesystem.listFilesRecursive ../../modules));
     
    mySystem = {
        theme.everforest.enable = true;
        applications = {
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
            prismlauncher.enable = false;
            ssh.enable = true;
            swayidle.enable = false;
            virt-manager.enable = false;
            zen-browser.enable = false;
        };
        boot.enableSecureBoot = false;
        boot.enablePlymouth = false;
    };

    boot.loader.systemd-boot.enable = lib.mkForce false;
}
