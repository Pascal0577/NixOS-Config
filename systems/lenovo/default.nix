{ pkgs, lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules
        ../../modules/applications/swayidle.nix
        ../../modules/themes/everforest.nix
    ];

    terminal.alacritty = true;
    launcher.fuzzel.enable = true;

    hardware = {
        graphics.enable = true;
        bluetooth.enable = true;
    };

    programs.niri.package = lib.mkForce pkgs.niri-stable;
}
