{ lib, ... }:

{
    options.mySystem.applications.launcher = {
        choice = lib.mkOption {
            type = lib.types.enum [ "vicinae" "fuzzel" "dmenu" "none" ];
            default = "none";
        };

        command = lib.mkOption {
            type = lib.types.str;
            default = "fuzzel";
            description = "Command used to open the launcher";
        };
    };
}
