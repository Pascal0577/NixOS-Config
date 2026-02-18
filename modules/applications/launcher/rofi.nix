{ pkgs, lib, config, ... }:

{
    options.mySystem.applications.launcher.rofi.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable my rofi module";
    };

    config = lib.mkIf config.mySystem.applications.launcher.rofi.enable {
        mySystem.applications.launcher = {
            package = pkgs.rofi;
            command = "rofi -modes drun -show drun";
        };
        environment.systemPackages = [ pkgs.rofi ];
    };
}
