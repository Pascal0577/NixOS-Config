{
    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        niri.url = "github:sodiboo/niri-flake";
        vicinae.url = "github:vicinaehq/vicinae";

        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        zen-browser.url = "github:0xc000022070/zen-browser-flake";
        zen-browser.inputs.nixpkgs.follows = "nixpkgs";

        nixvim.url = "github:nix-community/nixvim";
        nixvim.inputs.nixpkgs.follows = "nixpkgs";

        plasma-manager.url = "github:nix-community/plasma-manager";
        plasma-manager.inputs.nixpkgs.follows = "nixpkgs";

        # Secure Boot
        lanzaboote.url = "github:nix-community/lanzaboote/v0.4.2";
        lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

        nix-gaming.url = "github:fufexan/nix-gaming";
        nix-gaming.inputs.nixpkgs.follows = "nixpkgs";

        noctalia.url = "github:noctalia-dev/noctalia-shell";
        noctalia.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs:
        let
            system = "x86_64-linux";
            pkgs = nixpkgs.legacyPackages.${system};
            username = "pascal";
            hostname = "nixos";
        in
    {
        nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs username hostname; };

            modules = [
                home-manager.nixosModules.home-manager
                ./modules
                {
                    mySystem = {
                        desktop = {
                            niri.enable = true;
                            niri.noctalia.enable = true;
                            gnome.enable = false;
                            kde.enable = false;
                        };
                        neovim.enable = true;
                        nvidia.enable = true;
                        secure-boot.enable = true;
                    };
                }
            ];
        };
    };
}
