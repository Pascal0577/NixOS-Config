{ pkgs, config, lib, ... }:

{
    options.mySystem.applications.mullvad.enable =
        lib.mkEnableOption "Mullvad VPN module" // { default = true; };

    config = lib.mkIf config.mySystem.applications.mullvad.enable {
        services.mullvad-vpn = {
            enable = true;
            package = pkgs.mullvad-vpn;
        };
    };
}
