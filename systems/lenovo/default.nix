{ pkgs, lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules
        ../../modules/applications/terminal/alacritty.nix
        ../../modules/applications/launcher/fuzzel.nix
        ../../modules/applications/swayidle.nix
        ../../modules/themes/everforest.nix
    ];

    hardware = {
        graphics.enable = true;
        bluetooth.enable = true;
    };

    programs.niri.package = lib.mkForce pkgs.niri-stable;
}
