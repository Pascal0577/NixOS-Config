{
    imports = [
        ./boot.nix
        ./locale-time.nix
        ./power-management.nix
        ./services
        ./users.nix
        ./applications
    ];

    security.rtkit.enable = true;
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "26.05";
}
