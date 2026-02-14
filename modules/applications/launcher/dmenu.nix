{ config, pkgs, lib, ... }:
let
    hue = config.lib.stylix.colors;
in
{
    options.launcher.dmenu.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable my dmenu module";
    };

    config = lib.mkIf config.launcher.dmenu.enable {
        launcher.package = pkgs.dmenu;
        launcher.command = "dmenu_run -nb #${hue.base00-hex} -nf #${hue.base05-hex} -sb #${hue.base02-hex} -sf #${hue.base04-hex}";
        environment.systemPackages = [ pkgs.dmenu ];
    };
}
