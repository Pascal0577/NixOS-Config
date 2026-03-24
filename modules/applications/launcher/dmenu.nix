{ config, pkgs, lib, ... }:
let
    hue = config.lib.stylix.colors;
in
{
    options.mySystem.applications.launcher.dmenu.enable =
        lib.mkEnableOption "dmenu module";
    
    config = lib.mkIf config.mySystem.applications.launcher.dmenu.enable {
        environment.systemPackages = [ pkgs.dmenu ];
        mySystem.applications.launcher = {
            package = pkgs.dmenu;
            command = "dmenu_run -nb #${hue.base00-hex} -nf #${hue.base05-hex} -sb #${hue.base02-hex} -sf #${hue.base04-hex}";
        };
    };
}
