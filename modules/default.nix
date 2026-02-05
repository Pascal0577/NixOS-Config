{ hostname, pkgs, ... }:

{
    imports = [
        ./boot.nix
        ./locale-time.nix
        ./power-management.nix
        ./services
        ./users.nix
        ./themes/everforest.nix
        ./applications/appimage.nix
        ./applications/fastfetch.nix
        ./applications/ghostty.nix
        ./applications/git.nix
        ./applications/heroic.nix
        ./applications/kmscon.nix
        ./applications/mathematica.nix
        ./applications/mullvad.nix
        ./applications/nautilus.nix
        ./applications/neovim
        ./applications/obs-studio.nix
        ./applications/swayidle.nix
        ./applications/virt-manager.nix
        ./applications/zen-browser.nix
        ./applications/zsh.nix
    ];

    environment.systemPackages = with pkgs; [
        playerctl
        losslesscut-bin
        pinta
        deluge
        onlyoffice-desktopeditors
        prismlauncher
    ];

    networking = {
        hostName = hostname;
        networkmanager.enable = true;
        modemmanager.enable = false;
        firewall = {
            enable = true;
            trustedInterfaces = [ "virbr0" ];
            allowedTCPPorts = [ 25565 ]; # Minecraft
        };
    };

    security.rtkit.enable = true;

    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "26.05";
}
