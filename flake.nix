{
    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        niri.url = "github:sodiboo/niri-flake";

        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        zen-browser.url = "github:0xc000022070/zen-browser-flake";
        zen-browser.inputs.nixpkgs.follows = "nixpkgs";

        nixvim.url = "github:nix-community/nixvim";
        nixvim.inputs.nixpkgs.follows = "nixpkgs";

        plasma-manager.url = "github:nix-community/plasma-manager";
        plasma-manager.inputs.nixpkgs.follows = "nixpkgs";

        lanzaboote.url = "github:nix-community/lanzaboote";
        lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

        nix-gaming.url = "github:fufexan/nix-gaming";
        nix-gaming.inputs.nixpkgs.follows = "nixpkgs";

        quickshell.url = "github:outfoxxed/quickshell";
        quickshell.inputs.nixpkgs.follows = "nixpkgs";

        noctalia.url = "github:noctalia-dev/noctalia-shell";
        noctalia.inputs.nixpkgs.follows = "nixpkgs";

        stylix.url = "github:nix-community/stylix";
        stylix.inputs.nixpkgs.follows = "nixpkgs";

        elephant.url = "github:abenz1267/elephant";
        walker = {
            url = "github:abenz1267/walker";
            inputs.elephant.follows = "elephant";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        vicinae.url = "github:vicinaehq/vicinae";
        vicinae-extensions = {
            url = "github:vicinaehq/extensions";
           inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs:
        let
            username = "pascal";
        in
    {
        nixosConfigurations = {
            nixos = nixpkgs.lib.nixosSystem {
                specialArgs = {
                    inherit inputs username;
                    hostname = "nixos";
                };
                modules = [
                    home-manager.nixosModules.home-manager
                    ./modules
                    ./systems/acer
                ];
            };

            lenovo = nixpkgs.lib.nixosSystem {
                specialArgs = {
                    inherit inputs username;
                    hostname = "lenovo";
                };
                modules = [
                    home-manager.nixosModules.home-manager
                    ./modules
                    ./systems/lenovo
                ];
            };
        };
    };
}
