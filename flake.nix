{
    outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
        mkSystem = { name }:
            nixpkgs.lib.nixosSystem {
                specialArgs = {
                    inherit inputs;
                    hostname = name;
                    username = "pascal";
                };
                modules = [
                    home-manager.nixosModules.home-manager
                    (./systems + "/${name}/default.nix")
                    (./systems + "/${name}/hardware-configuration.nix")
                ]
                ++ nixpkgs.lib.filesystem.listFilesRecursive ./modules;
            };
    in
    {
        nixosConfigurations = builtins.listToAttrs (map
            (name: { inherit name; value = mkSystem { inherit name; }; })
            [ "acer" "lenovo" "oracle" "chronos" ]
        );

        # expose environment.systemPackages and custom packages as flake outputs
        packages.x86_64-linux =
        let
            sysPkgs = self.nixosConfigurations.acer.config.environment.systemPackages;
            named = builtins.listToAttrs (map (p: {
              name = p.pname or p.name;
              value = p;
            }) sysPkgs);

            customPkgs = map (x: nixpkgs.legacyPackages.x86_64-linux.callPackage x {}) (
                nixpkgs.lib.filesystem.listFilesRecursive ./packages
            );
            customNamed = builtins.listToAttrs (map (p: {
              name = p.pname or p.name;
              value = p;
            }) customPkgs);
        in named // customNamed;
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

        niri.url = "github:sodiboo/niri-flake";
        noctalia.url = "github:noctalia-dev/noctalia-shell/legacy-v4";

        hyprland.url = "github:vaxerski/Hyprland/layouts-rethonked";
        mithril-shell.url = "github:andreashgk/mithril-shell";

        oxwm.url = "github:tonybanters/oxwm";
        oxwm.inputs.nixpkgs.follows = "nixpkgs";

        vicinae.url = "github:vicinaehq/vicinae";
        vicinae-extensions.url = "github:vicinaehq/extensions";
        vicinae-extensions.inputs.nixpkgs.follows = "nixpkgs";

        zen-browser.url = "github:0xc000022070/zen-browser-flake";
        zen-browser.inputs.nixpkgs.follows = "nixpkgs";

        nixvim.url = "github:nix-community/nixvim";
        nixvim.inputs.nixpkgs.follows = "nixpkgs";
    };
}
