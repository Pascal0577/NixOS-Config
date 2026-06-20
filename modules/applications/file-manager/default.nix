{ lib, ... }:

{
    options.mySystem.applications.file-manager.choice = lib.mkOption {
        type = lib.types.enum [ "nautilus" "yazi" "none" ];
        default = "none";
    };
}
