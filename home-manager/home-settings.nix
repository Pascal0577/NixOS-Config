{ pkgs, username, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
    packages = with pkgs; [
      playerctl
      losslesscut-bin
      pinta
      qbittorrent
    ];

    file = { };

    sessionVariables = { };
  };

  programs = {
    home-manager.enable = true;
  };
}
