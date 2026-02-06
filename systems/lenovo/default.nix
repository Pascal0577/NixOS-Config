{ pkgs, lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules
        ../../modules/applications/niri
        ../../modules/themes/sakura.nix
    ];

    hardware = {
        graphics.enable = true;
        bluetooth.enable = true;
    };

    programs.niri.package = lib.mkForce pkgs.niri-stable;
}
