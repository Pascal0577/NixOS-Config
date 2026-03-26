{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager  = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
        stylix        = { url = "github:nix-community/stylix";       inputs.nixpkgs.follows = "nixpkgs"; };
        disko         = { url = "github:nix-community/disko/latest"; inputs.nixpkgs.follows = "nixpkgs"; };
        lanzaboote    = { url = "github:nix-community/lanzaboote";   inputs.nixpkgs.follows = "nixpkgs"; };
        impermanence  = { url = "github:nix-community/impermanence"; inputs.nixpkgs.follows = ""; inputs.home-manager.follows = ""; };

        nixos-raspberrypi = { url = "github:nvmd/nixos-raspberrypi/main"; inputs.nixpkgs.follows = "nixpkgs"; };

        niri.url       = "github:sodiboo/niri-flake";
        hyprland.url   = "github:vaxerski/Hyprland/layouts-rethonked";
        mithril-shell  = { url = "github:andreashgk/mithril-shell"; };
        oxwm           = { url = "github:tonybanters/oxwm";             inputs.nixpkgs.follows = "nixpkgs"; };
        plasma-manager = { url = "github:nix-community/plasma-manager"; inputs.nixpkgs.follows = "nixpkgs"; };

        zen-browser  = { url = "github:0xc000022070/zen-browser-flake"; inputs.nixpkgs.follows = "nixpkgs"; };
        nixvim       = { url = "github:nix-community/nixvim";           inputs.nixpkgs.follows = "nixpkgs"; };
        elephant.url = "github:abenz1267/elephant";
        walker       = { url = "github:abenz1267/walker";               inputs.elephant.follows = "elephant"; inputs.nixpkgs.follows = "nixpkgs"; };
        vicinae.url  = "github:vicinaehq/vicinae";
        vicinae-extensions = { url = "github:vicinaehq/extensions";     inputs.nixpkgs.follows = "nixpkgs"; };

        noctalia-qs = { url = "github:noctalia-dev/noctalia-qs";    inputs.nixpkgs.follows = "nixpkgs"; };
        noctalia    = { url = "github:noctalia-dev/noctalia-shell"; inputs.nixpkgs.follows = "nixpkgs";   inputs.noctalia-qs.follows = "noctalia-qs"; };
    };

    nixConfig = {
        extra-substituters = [ "https://nixos-raspberrypi.cachix.org" ];
        extra-trusted-public-keys = [ "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI=" ];
    };

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
                ++ lib.filesystem.listFilesRecursive ./modules
                ++ extraModules;
            };
    in
    {
        nixosConfigurations = {
            acer = mkSystem { name = "acer"; };
            lenovo = mkSystem { name = "lenovo"; };
            oracle = mkSystem {
                name = "oracle";
                extraArgs = { useNiri = false; };
            };

            raspberry = mkSystem {
                name = "raspberry";
                lib = nixos-raspberrypi.lib;
                extraArgs = { inherit nixos-raspberrypi; useNiri = false; };
            };
        };

        packages.aarch64-linux.pi5-image =
            self.nixosConfigurations.raspberry.config.system.build.sdImage;
    };
}
