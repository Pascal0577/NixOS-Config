{ pkgs, ... }:

{
    imports = [
        ./appimage.nix
        ./desktop
        ./discord.nix
        ./fastfetch.nix
        ./file-manager
        ./git.nix
        ./heroic.nix
        ./kmscon.nix
        ./launcher
        ./mathematica.nix
        ./mullvad.nix
        ./neovim
        ./obs-studio.nix
        ./pipewire.nix
        ./terminal
        ./virt-manager.nix
        ./xserver.nix
        ./zen-browser.nix
        ./zsh.nix
    ];

    environment.systemPackages = with pkgs; [
        playerctl
        losslesscut-bin
        pinta
        deluge
        onlyoffice-desktopeditors
        prismlauncher
    ];
}
