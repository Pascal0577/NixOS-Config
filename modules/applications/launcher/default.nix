{ lib, ... }:

{
    options.launcherCommand = lib.mkOption {
        type = lib.types.str;
        default = "vicinae vicinae://toggle";
        description = "Command used to open the launcher";
    };

    imports = [ ./dmenu.nix ];
}
