{ lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ] ++ lib.filesystem.listFilesRecursive ../../modules;

    mySystem = {
        ZFS.enable = true;
        impermanence.enable = true;
    };
}
