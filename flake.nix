{
    outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
        lib = nixpkgs.lib;

        sharedModules = ./modules
            |> lib.filesystem.listFilesRecursive
            |> builtins.filter (lib.hasSuffix ".nix");

        mkSystem = hostname: lib.nixosSystem {
            specialArgs = { inherit inputs self hostname; username = "pascal"; };
            modules = [
                home-manager.nixosModules.home-manager
                ./systems/${hostname}/default.nix
                ./systems/${hostname}/hardware-configuration.nix
            ] ++ sharedModules;
        };
    in
    {
        nixosConfigurations = lib.genAttrs [ "acer" "lenovo" "oracle" "chronos" ] mkSystem;

        # expose custom packages as flake outputs for all supported archs
        packages = let
            systems = [ "x86_64-linux" "aarch64-linux" ];
            mkPackages = system: lib.filesystem.listFilesRecursive ./packages
                |> lib.filter (lib.hasSuffix ".nix")
                |> map (p: nixpkgs.legacyPackages.${system}.callPackage p {})
                |> map (p: { name = p.pname or p.name; value = p; })
                |> lib.listToAttrs;
        in lib.genAttrs systems mkPackages;
    };

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        stylix.url = "github:nix-community/stylix";
        stylix.inputs.nixpkgs.follows = "nixpkgs";

        disko.url = "github:nix-community/disko/latest";
        disko.inputs.nixpkgs.follows = "nixpkgs";

        lanzaboote.url = "github:nix-community/lanzaboote";
        lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

        impermanence.url = "github:nix-community/impermanence";
        impermanence.inputs.nixpkgs.follows = "";
        impermanence.inputs.home-manager.follows = "";

        website.url = "github:Pascal0577/website";

        niri.url = "github:sodiboo/niri-flake/refs/pull/1731/head";
        niri.inputs.nixpkgs.follows = "nixpkgs";
        
        noctalia.url = "github:noctalia-dev/noctalia-shell/legacy-v4";
        noctalia.inputs.nixpkgs.follows = "nixpkgs";

        oxwm.url = "github:tonybanters/oxwm";
        oxwm.inputs.nixpkgs.follows = "nixpkgs";

        zen-browser.url = "github:0xc000022070/zen-browser-flake";
        zen-browser.inputs.nixpkgs.follows = "nixpkgs";

        nixvim.url = "github:nix-community/nixvim";
        nixvim.inputs.nixpkgs.follows = "nixpkgs";
    };
}
