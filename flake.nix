{
    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixos-hardware.url = "github:nixos/nixos-hardware";
        raspberry-pi-nix.url = "github:nix-community/raspberry-pi-nix/";

        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        zen-browser.url = "github:0xc000022070/zen-browser-flake";
        zen-browser.inputs.nixpkgs.follows = "nixpkgs";

        nixvim.url = "github:nix-community/nixvim";
        nixvim.inputs.nixpkgs.follows = "nixpkgs";

        niri.url = "github:sodiboo/niri-flake";

        plasma-manager.url = "github:nix-community/plasma-manager";
        plasma-manager.inputs.nixpkgs.follows = "nixpkgs";

        lanzaboote.url = "github:nix-community/lanzaboote";
        lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

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

        hyprland.url = "github:vaxerski/Hyprland/layouts-rethonked";
        mithril-shell.url = "github:andreashgk/mithril-shell";

        oxwm.url = "github:tonybanters/oxwm";
        oxwm.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }@inputs:
    {
        nixosConfigurations = {
            nixos = nixpkgs.lib.nixosSystem {
                specialArgs = {
                    inherit inputs;
                    hostname = "nixos";
                    username = "pascal";
                };
                modules = [
                    home-manager.nixosModules.home-manager
                    ./systems/acer
                ];
            };

            lenovo = nixpkgs.lib.nixosSystem {
                specialArgs = {
                    inherit inputs;
                    hostname = "lenovo";
                    username = "pascal";
                };
                modules = [
                    home-manager.nixosModules.home-manager
                    ./systems/lenovo
                ];
            };

            raspberry = nixpkgs.lib.nixosSystem {
                system = "aarch64-linux";
                specialArgs = {
                    inherit inputs;
                    hostname = "raspberry";
                    username = "pascal";
                };
                modules = [
                    nixos-hardware.nixosModules.raspberry-pi-5
                    home-manager.nixosModules.home-manager
                    inputs.raspberry-pi-nix.nixosModules.raspberry-pi
                    inputs.raspberry-pi-nix.nixosModules.sd-image
                    ./systems/raspberry
                ];
            };
        };

        packages.aarch64-linux.pi5-image = self.nixosConfigurations.raspberry.config.system.build.sdImage;
    };
}
