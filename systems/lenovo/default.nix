{ pkgs, lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules/desktop/hyprland
    ];
    programs.niri.package = lib.mkForce pkgs.niri-stable;
}
