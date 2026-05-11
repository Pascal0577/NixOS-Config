{
    outputs = { self, nixpkgs, nixos-raspberrypi, home-manager, ... }@inputs:
    let
        mkSystem = { name, lib ? nixpkgs.lib, extraArgs ? {}, extraModules ? [] }: 
            lib.nixosSystem {
                specialArgs = {
                    inherit inputs;
                    hostname = name;
                    username = "pascal";
                } // extraArgs;
                modules = [
                    home-manager.nixosModules.home-manager
                    (./systems + "/${name}/default.nix")
                    (./systems + "/${name}/hardware-configuration.nix")
                ]
                ++ nixpkgs.lib.filesystem.listFilesRecursive ./modules
                ++ extraModules;
            };
    in
    {
        nixosConfigurations = {
            acer = mkSystem { name = "acer"; };
            lenovo = mkSystem { name = "lenovo"; };
            oracle = mkSystem { name = "oracle"; };
            chronos = mkSystem { name = "chronos"; };

            raspberry = mkSystem {
                name = "raspberry";
                lib = nixos-raspberrypi.lib;
                extraArgs = { inherit nixos-raspberrypi; };
            };
        };

        packages.aarch64-linux.pi5-image =
            self.nixosConfigurations.raspberry.config.system.build.sdImage;
    };

    nixConfig = {
        extra-substituters = [ "https://nixos-raspberrypi.cachix.org" ];
        extra-trusted-public-keys = [ "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI=" ];
    };

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
        nixos-raspberrypi.inputs.nixpkgs.follows = "nixpkgs";

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

        niri.url = "github:sodiboo/niri-flake";

        hyprland.url = "github:vaxerski/Hyprland/layouts-rethonked";
        mithril-shell.url = "github:andreashgk/mithril-shell";

        oxwm.url = "github:tonybanters/oxwm";
        oxwm.inputs.nixpkgs.follows = "nixpkgs";

        plasma-manager.url = "github:nix-community/plasma-manager";
        plasma-manager.inputs.nixpkgs.follows = "nixpkgs";

        elephant.url = "github:abenz1267/elephant";
        walker.url = "github:abenz1267/walker";
        walker.inputs.elephant.follows = "elephant";
        walker.inputs.nixpkgs.follows = "nixpkgs";

        vicinae.url = "github:vicinaehq/vicinae";
        vicinae-extensions.url = "github:vicinaehq/extensions";
        vicinae-extensions.inputs.nixpkgs.follows = "nixpkgs";
    
        noctalia.url = "github:noctalia-dev/noctalia-shell";
        noctalia.inputs.nixpkgs.follows = "nixpkgs";

        zen-browser.url = "github:0xc000022070/zen-browser-flake";
        zen-browser.inputs.nixpkgs.follows = "nixpkgs";

        nixvim.url = "github:nix-community/nixvim";
        nixvim.inputs.nixpkgs.follows = "nixpkgs";
    };
}
