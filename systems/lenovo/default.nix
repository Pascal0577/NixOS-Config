{ pkgs, lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules
        ../../modules/applications/swayidle.nix
        ../../modules/themes/everforest.nix
    ];

    terminal.alacritty.enable = true;
    launcher.fuzzel.enable = true;
    file-manager.yazi.enable = true;

    hardware = {
        graphics.enable = true;
        bluetooth.enable = true;
    };

    programs.niri.package = lib.mkForce pkgs.niri-stable;
}
