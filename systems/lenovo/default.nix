{ username, pkgs, lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules/desktop/niri
    ];
    home-manager.users.${username}.stylix.targets.gtk.enable = true;
    programs.niri.package = lib.mkForce pkgs.niri-stable;
}
