{ pkgs }:

{
    imports = [
        ./appimage.nix
        ./fastfetch.nix
        ./ghostty.nix
        ./git.nix
        ./heroic.nix
        ./kmscon.nix
        ./mathematica.nix
        ./mullvad.nix
        ./nautilus.nix
        ./neovim
        ./obs-studio.nix
        ./swayidle.nix
        ./virt-manager.nix
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
