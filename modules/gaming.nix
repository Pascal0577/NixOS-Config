{ pkgs, inputs, ... }:
let
    gamePkgs = inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system};
in
{
    nix.settings = {
        substituters = ["https://nix-gaming.cachix.org"];
        trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
    };

    environment.systemPackages = with pkgs; [
        mangohud
        heroic
        unzip
        cabextract
        prismlauncher
    ];

    imports = [
        inputs.nix-gaming.nixosModules.platformOptimizations
        inputs.nix-gaming.nixosModules.wine
    ];

    programs = {
        gamemode.enable = true;
        wine = {
            enable = true;
            package = pkgs.wine-staging;
            binfmt = true;
            ntsync = true;
        };

        steam = {
            enable = true;
            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = true;
            localNetworkGameTransfers.openFirewall = true;
            extraCompatPackages =  [ pkgs.proton-ge-bin ];
            platformOptimizations.enable = true;
        };
    };
}
