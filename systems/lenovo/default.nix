{ pkgs, lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules/applications/niri
    ];
    programs.niri.package = lib.mkForce pkgs.niri-stable;
}
