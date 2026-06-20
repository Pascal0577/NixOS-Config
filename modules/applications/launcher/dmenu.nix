{ config, pkgs, lib, ... }:

{
    config = lib.mkIf (config.mySystem.applications.launcher.choice == "dmenu") {
        environment.systemPackages = [ pkgs.dmenu ];
        mySystem.applications.launcher.command =
            let
                hue = config.lib.stylix.colors;
            in
            "dmenu_run -nb #${hue.base00-hex} -nf #${hue.base05-hex} -sb #${hue.base02-hex} -sf #${hue.base04-hex}";
    };
}
