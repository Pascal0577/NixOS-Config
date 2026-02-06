{ lib, types, ... }:

{
    options.launcherCommand = lib.mkOption {
        type = types.str;
        default = "vicinae vicinae://toggle";
        description = "Command used to open the launcher";
    };

    config = {
        imports = [ ./vicinae.nix ];
    };
}
