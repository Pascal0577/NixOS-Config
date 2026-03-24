{ lib, inputs, ... }:

{
    # Exclude the niri module because for some reason including the flake's
    # nixos module forces a build a niri
    imports = with inputs.nixos-raspberrypi.nixosModules; [
        ./hardware-configuration.nix
        raspberry-pi-5.base
        raspberry-pi-5.page-size-16k
        raspberry-pi-5.display-vc4
        raspberry-pi-5.bluetooth
    ] ++ (lib.filter 
        (f: !(lib.hasSuffix "desktop/niri/default.nix" (toString f)))
        (lib.filesystem.listFilesRecursive ../../modules));
     
    mySystem = {
        server.enable = true;
        theme.everforest.enable = true;
    };

    networking.interfaces.end0.ipv4.addresses = [{
        address = "169.254.0.2";
        prefixLength = 24;
    }];
}
