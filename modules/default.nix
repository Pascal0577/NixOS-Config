{ pkgs, ... }:

{
    imports = [
        ./applications/appimage.nix
        ./applications/discord.nix
        ./applications/fastfetch.nix
        ./applications/file-manager
        ./applications/git.nix
        ./applications/heroic.nix
        ./applications/kmscon.nix
        ./applications/launcher
        ./applications/mathematica.nix
        ./applications/mullvad.nix
        ./applications/neovim
        ./applications/noctalia.nix
        ./applications/obs-studio.nix
        ./applications/onlyoffice.nix
        ./applications/pipewire.nix
        ./applications/ssh.nix
        ./applications/swayidle.nix
        ./applications/terminal
        ./applications/virt-manager.nix
        ./applications/zen-browser.nix
        ./applications/zsh.nix

        ./applications/desktop/gnome
        ./applications/desktop/kde
        ./applications/desktop/niri
        ./applications/desktop/hyprland
        ./applications/desktop/oxwm

        ./boot.nix
        ./locale-time.nix
        ./networking.nix
        ./power-management.nix
        ./users.nix
        ./xserver.nix
    ];

    security.rtkit.enable = true;
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "26.05";

    environment.systemPackages = with pkgs; [
        playerctl
        losslesscut-bin
        pinta
        deluge
        prismlauncher
    ];

    systemd = {
        # If a service has tried to stop for longer than 10s 
        # something has gone wrong and it should be force stopped
        user.extraConfig = "DefaultTimeoutStopSec=10s";
        settings.Manager = {
            DefaultTimeoutStopSec = "10s";
        };

        services = {
            "serial-getty@".enable = false;
            NetworkManager-wait-online.enable = false;
        };
    };
}
