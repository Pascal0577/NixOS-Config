{ inputs, ... }:

{
    imports = [
        inputs.niri.nixosModules.niri
    ];

    programs.niri.enable = true;
    niri-flake.cache.enable = true;
}
