{ lib, config, inputs,... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules/applications/zsh.nix
        ../../modules/applications/fastfetch.nix
        ../../modules/applications/git.nix
        ../../modules/applications/kmscon.nix
        ../../modules/applications/ssh.nix
        ../../modules/applications/neovim
        ../../modules/applications/terminal
        ../../modules/themes
        ../../modules/themes/everforest.nix
        ../../modules/default.nix
        ../../modules/boot.nix
        ../../modules/locale-time.nix
        ../../modules/networking.nix
        ../../modules/users.nix
        ../../modules/power-management.nix
        ../../modules/xserver.nix
    ];
     
    mySystem = {
        theme.everforest.enable = true;
        applications = {
            zsh.enable = true;
            # appimage.enable = false;
            # discord.enable = false;
            fastfetch.enable = true;
            git.enable = true;
            # heroic.enable = false;
            kmscon.enable = true;
            # mathematica.enable = false;
            # mullvad.enable = false;
            # noctalia.enable = false;
            # obs.enable = false;
            # onlyoffice.enable = false;
            # pipewire.enable = false;
            # prismlauncher.enable = false;
            ssh.enable = true;
            # swayidle.enable = false;
            # virt-manager.enable = false;
            # zen-browser.enable = false;
        };
        # desktop.niri.enable = false;
        boot.enableSecureBoot = false;
        boot.enablePlymouth = false;
    };

    boot.loader.systemd-boot.enable = lib.mkForce false;
}
