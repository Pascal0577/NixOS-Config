{ lib, inputs, ... }:

{
    nix.settings = {
        extra-substituters = [ "https://nixos-raspberrypi.cachix.org" ];
        extra-trusted-public-keys = [ "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI=" ];
    };
    
    # Exclude the niri module because for some reason including the flake's
    # nixos module forces a build a niri
    imports = with inputs.nixos-raspberrypi.nixosModules; [
        ./hardware-configuration.nix
        raspberry-pi-5.base
        raspberry-pi-5.page-size-16k
        raspberry-pi-5.display-vc4
        raspberry-pi-5.bluetooth
        inputs.nixos-raspberrypi.lib.inject-overlays-global
        trusted-nix-caches
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
