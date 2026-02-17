{ pkgs, config, lib, ... }:

{
    options.mySystem.applications.mullvad.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable my Mullvad module";
    };

    config = lib.mkIf config.mySystem.applications.mullvad.enable {
        services.mullvad-vpn = {
            enable = true;
            package = pkgs.mullvad-vpn;
        };
    };
}
