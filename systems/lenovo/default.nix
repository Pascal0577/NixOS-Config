{ username, pkgs, ... }:
{
    imports = [
        ./hardware-configuration.nix
        ../../modules/desktop/gnome
    ];
    home-manager.users.${username}.stylix.targets.gtk.enable = true;
    programs.niri.package = pkgs.niri-stable;
}
