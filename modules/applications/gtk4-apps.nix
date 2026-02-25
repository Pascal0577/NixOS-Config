{ pkgs, lib, config, ... }:

{
    options.mySystem.applications.gtk4-apps.enable = lib.mkEnableOption "gtk4-apps";

    config = lib.mkIf config.mySystem.applications.gtk4-apps.enable {
        environment.systemPackages = with pkgs; [
            showtime
            baobab
            constrict
        ];
    };
}
