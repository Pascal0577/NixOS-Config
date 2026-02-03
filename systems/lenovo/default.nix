{ pkgs, lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules/desktop/niri
    ];
    programs.niri.package = lib.mkForce pkgs.niri-stable;
}
