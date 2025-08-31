{ pkgs, username, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
    packages = with pkgs; [
      playerctl
      wineWowPackages.staging
      icoutils
      unrar
    ];

    file = {

    };

    sessionVariables = {
      LD_LIBRARY_PATH = /run/current-system/sw/share/nix-ld/lib;
    };
  };

  programs = {
    home-manager.enable = true;
    mangohud.enable = true;
  };
}
