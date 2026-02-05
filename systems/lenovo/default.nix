{ pkgs, lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules/applications/niri
    ];

    hardware = {
        graphics.enable = true;
        bluetooth.enable = true;
    };

    programs.niri.package = lib.mkForce pkgs.niri-stable;
}
