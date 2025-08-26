{ pkgs, ... }:

{
  imports = [ 
    ./modules/zen-browser.nix
    ./modules/gnome.nix
    ./modules/neovim.nix
    ./modules/git.nix
    ./modules/shell.nix
    ./modules/ghostty.nix
    ./modules/discord.nix
    ./modules/obs-studio.nix
    ./modules/fastfetch.nix
  ];

  home.username = "pascal";
  home.homeDirectory = "/home/pascal";

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "25.05";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    ghostty
    celluloid
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  programs = {
    home-manager.enable = true;
  };
}
