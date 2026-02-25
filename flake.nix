{
    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        stylix.url = "github:nix-community/stylix";
        stylix.inputs.nixpkgs.follows = "nixpkgs";

        nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

        home-manager-stable.url = "github:nix-community/home-manager/release-25.11";
        home-manager-stable.inputs.nixpkgs.follows = "nixpkgs-stable";

        stylix-stable.url = "github:nix-community/stylix/release-25.11";
        stylix-stable.inputs.nixpkgs.follows = "nixpkgs-stable";

        nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";

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

    nixConfig = {
        extra-substituters = [
            "https://nixos-raspberrypi.cachix.org"
        ];
        extra-trusted-public-keys = [
            "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
        ];
    };

    outputs = { self, nixpkgs, nixos-raspberrypi, home-manager, home-manager-stable, ... }@inputs:
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
                    stylix = inputs.stylix-stable;
                    hostname = "raspberry";
                    username = "pascal";
                };
                modules = [
                    home-manager-stable.nixosModules.home-manager
                    nixos-raspberrypi.nixosModules.sd-image
                    ./systems/raspberry
                    { sdImage.compressImage = false; }
                ];
            };
        };

        disabledModules = [ "rename.nix" ];
        packages.aarch64-linux.pi5-image = self.nixosConfigurations.raspberry.config.system.build.sdImage;
    };
}
