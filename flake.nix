{
    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        stylix.url = "github:nix-community/stylix";
        stylix.inputs.nixpkgs.follows = "nixpkgs";

        disko.url = "github:nix-community/disko/latest";
        disko.inputs.nixpkgs.follows = "nixpkgs";

        impermanence.url = "github:nix-community/impermanence";
        impermanence.inputs.nixpkgs.follows = "";
        impermanence.inputs.home-manager.follows = "";

        nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/develop";
        nixos-raspberrypi.inputs.nixpkgs.follows = "nixpkgs";

        zen-browser.url = "github:0xc000022070/zen-browser-flake";
        zen-browser.inputs.nixpkgs.follows = "nixpkgs";

        nixvim.url = "github:nix-community/nixvim";
        nixvim.inputs.nixpkgs.follows = "nixpkgs";

        niri.url = "github:sodiboo/niri-flake";

        plasma-manager.url = "github:nix-community/plasma-manager";
        plasma-manager.inputs.nixpkgs.follows = "nixpkgs";

        lanzaboote.url = "github:nix-community/lanzaboote";
        lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

        noctalia = {
            url = "github:noctalia-dev/noctalia-shell";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.noctalia-qs.follows = "noctalia-qs";
        };

        noctalia-qs = {
            url = "github:noctalia-dev/noctalia-qs";
            inputs.nixpkgs.follows = "nixpkgs";
        };

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

    outputs = { self, nixpkgs, nixos-raspberrypi, home-manager, ... }@inputs:
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

            raspberry = nixos-raspberrypi.lib.nixosSystem {
                specialArgs = {
                    inherit inputs nixos-raspberrypi;
                    hostname = "raspberry";
                    username = "pascal";
                    useNiri = false;
                };
                modules = [
                    home-manager.nixosModules.home-manager
                    nixos-raspberrypi.nixosModules.sd-image
                    ./systems/raspberry
                    { sdImage.compressImage = false; }
                ];
            };
        };

        packages.aarch64-linux.pi5-image = self.nixosConfigurations.raspberry.config.system.build.sdImage;
        apps.x86_64-linux.build-pi = {
            type = "app";
            program = toString (nixpkgs.legacyPackages.x86_64-linux.writeShellScript "build-pi" ''
                nix build .#packages.aarch64-linux.pi5-image \
                    --extra-substituters "https://nixos-raspberrypi.cachix.org" \
                    --extra-trusted-public-keys "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI=" \
                    "$@"
            '');
        };
    };
}
