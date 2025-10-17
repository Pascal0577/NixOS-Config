{ pkgs, inputs, ... }:

{
    environment.systemPackages = with pkgs; [
        inputs.noctalia.packages.${system}.default
    ];

    imports = [
        inputs.noctalia.nixosModules.default
    ];

    services.noctalia-shell.enable = true;
}
