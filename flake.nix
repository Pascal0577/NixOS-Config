{
    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # Web Browser
        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # Declarative Neovim
        nixvim = {
            url = "github:nix-community/nixvim";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # Declarative KDE Plasma
        plasma-manager = {
            url = "github:nix-community/plasma-manager";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.home-manager.follows = "home-manager";
        };

        # Secure Boot
        lanzaboote = {
            url = "github:nix-community/lanzaboote/v0.4.2";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # Gaming
        nix-gaming = {
            url = "github:fufexan/nix-gaming";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        niri.url = "github:sodiboo/niri-flake";
        vicinae.url = "github:vicinaehq/vicinae";

        noctalia = {
          url = "github:noctalia-dev/noctalia-shell";
          inputs.nixpkgs.follows = "nixpkgs";
        };
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
            specialArgs = {
                inherit inputs;
                inherit username;
                inherit hostname;
            };

            modules = [
                home-manager.nixosModules.home-manager {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.extraSpecialArgs = { inherit inputs username; };
                    home-manager.users.${username} = {
                        home.username = username;
                        home.homeDirectory = "/home/${username}";
                        home.stateVersion = "25.11";
                        programs.home-manager.enable = true;
			        };
                }

                {
                    mySystem = {
                        desktop = {
                            niri.enable = true;
                            niri.noctalia.enable = true;
                            kde.enable = false;
                            gnome.enable = false;
                        };
                        neovim.enable = true;
                        nvidia.enable = true;
                    };
                }

                # Import desired system modules
                ./modules/appimage.nix
                ./modules/discord.nix
                ./modules/fastfetch.nix
                ./modules/ghostty.nix
                ./modules/git.nix
                ./modules/configuration.nix
                ./modules/hardware-configuration.nix
                ./modules/intel.nix
                ./modules/neovim.nix
                ./modules/nvidia.nix
                ./modules/obs-studio.nix
                ./modules/secure-boot.nix
                ./modules/shell.nix
                ./modules/steam.nix
                ./modules/zig.nix
                ./modules/virtualization.nix
                ./modules/desktop
            ];
        };
    };
}
