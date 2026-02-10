{ pkgs, lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules
        ../../modules/applications/launcher/fuzzel.nix
        ../../modules/applications/terminal/alacritty.nix
        ../../modules/themes/everforest.nix
    ];

    hardware = {
        graphics.enable = true;
        bluetooth.enable = true;
    };

    programs.niri.package = lib.mkForce pkgs.niri-stable;
}
