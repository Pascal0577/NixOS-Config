{ lib, pkgs, ... }:

{
    options.launcher = {
        package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.fuzzel;
            description = "Package for the launcher aapplication";
        };

        command = lib.mkOption {
            type = lib.types.str;
            default = "fuzzel";
            description = "Command used to open the launcher";
        };
    };

    imports = [
        ./dmenu.nix
        ./fuzzel.nix
        ./vicinae.nix
        ./walker.nix
    ];
}
