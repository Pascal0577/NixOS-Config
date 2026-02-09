{ config, pkgs, ... }:
let
    hue = config.lib.stylix.colors;
in
{
    launcherCommand = "dmenu_run -nb #${hue.base00-hex} -nf #${hue.base05-hex} -sb #${hue.base02-hex} -sf #${hue.base04-hex}";
    environment.systemPackages = [ pkgs.dmenu ];
}
