{ pkgs, inputs, username, ... }:

{
  users.users.${username}.packages = with pkgs; [
    mangohud
  ];

  imports = [
    inputs.nix-gaming.nixosModules.platformOptimizations
    inputs.nix-gaming.nixosModules.wine
  ];

  programs.wine = {
    enable = true;
    package = pkgs.wineWowPackages.stagingFull;
    binfmt = true;
    ntsync = true;
  };

  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages =  [ pkgs.proton-ge-bin ];
    platformOptimizations.enable = true;
  };
}
