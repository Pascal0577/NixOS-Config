{ lib, inputs, username, ... }:

{
    # Exclude the niri module because for some reason including the flake's
    # nixos module forces a build a niri
    imports = with inputs.nixos-raspberrypi.nixosModules; [
        ./hardware-configuration.nix
        raspberry-pi-5.base
        raspberry-pi-5.page-size-16k
        raspberry-pi-5.display-vc4
        raspberry-pi-5.bluetooth
    ] ++ (lib.filter 
        (f: !(lib.hasSuffix "desktop/niri/default.nix" (toString f)))
        (lib.filesystem.listFilesRecursive ../../modules));
     
    mySystem = {
        theme.everforest.enable = true;
        applications = {
            neovim.enable = true;
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

    security.sudo.wheelNeedsPassword = false;

    networking.interfaces.end0.ipv4.addresses = [{
        address = "169.254.0.2";
        prefixLength = 24;
    }];

    nixpkgs.overlays = [
        (final: prev: {
            xrdb = prev.xorg.xrdb;
        })
    ];
    boot.loader.systemd-boot.enable = lib.mkForce false;
}
