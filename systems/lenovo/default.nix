{ username, pkgs, ... }:
{
    imports = [
        ./hardware-configuration.nix
        ../../modules/desktop/gnome
    ];
    home-manager.users.${username}.stylix.targets.gtk.enable = true;
    programs.niri.package = pkgs.niri-stable;
    services.displayManager.autoLogin.enable  = true;
    services.displayManager.autoLogin.user = "pascal";
}
