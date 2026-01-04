{ pkgs, ... }:

{
    imports = [
        ./discord.nix
        ./fastfetch.nix
        ./ghostty.nix
        ./git.nix
        ./neovim.nix
        ./obs-studio.nix
        ./zen-browser.nix
    ];

    environment.systemPackages = with pkgs; [
        playerctl
        losslesscut-bin
        pinta
        deluge
        onlyoffice-desktopeditors
        lmstudio
    ];
}
