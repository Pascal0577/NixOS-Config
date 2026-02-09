{ config, pkgs, ... }:

{
    launcherCommand = "dmenu_run -nb #${config.lib.stylix.colors.base00-hex}";
    environment.systemPackages = [ pkgs.dmenu ];
}
