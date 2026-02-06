{
    imports = [
        ./applications
        ./boot.nix
        ./locale-time.nix
        ./networking.nix
        ./power-management.nix
        ./services
        ./users.nix
    ];

    security.rtkit.enable = true;
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "26.05";
}
