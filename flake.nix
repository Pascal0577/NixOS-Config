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
                # Import desired system modules
                ./nixos/gnome.nix
                ./nixos/system-settings.nix
                ./nixos/hardware-configuration.nix
                ./nixos/intel.nix
                ./nixos/nvidia.nix
                ./nixos/steam.nix
                ./nixos/secure-boot.nix
                ./nixos/appimage.nix
                ./nixos/virtualization.nix
            ];
        };

        homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            extraSpecialArgs = { 
                inherit inputs;
                inherit username;
            };

            modules = [
                # Import desired home modules
                ./home-manager/gnome.nix
                ./home-manager/home-settings.nix
                ./home-manager/zen-browser.nix
                ./home-manager/neovim.nix
                ./home-manager/git.nix
                ./home-manager/shell.nix
                ./home-manager/ghostty.nix
                ./home-manager/discord.nix
                ./home-manager/obs-studio.nix
                ./home-manager/fastfetch.nix
                ./home-manager/quarto.nix
                ./home-manager/zig.nix
                ./home-manager/onlyoffice.nix
            ];
        };
    };
}
