{ lib, pkgs, ... }:

{
    options.file-manager = {
        package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.nautilus;
        };
    };

    imports = [
        ./nautilus.nix
        ./yazi.nix
    ];
}
