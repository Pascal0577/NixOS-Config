{ pkgs, username, ... }:

{
  users.users.${username}.packages = with pkgs; [
    steam
  ];

  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
