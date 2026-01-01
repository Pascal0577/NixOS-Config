{ pkgs, inputs, ... }:

{
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
            package = pkgs.wineWowPackages.waylandFull;
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
