{ pkgs, ... }:

{
    imports = [
        ./appimage.nix
        ./bash.nix
        ./discord.nix
        ./fastfetch.nix
        ./git.nix
        ./heroic.nix
        ./kmscon.nix
        ./launcher
        ./mathematica.nix
        ./mullvad.nix
        ./nautilus.nix
        ./neovim
        ./niri
        ./obs-studio.nix
        ./pipewire.nix
        ./swayidle.nix
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
