{ pkgs, username, ... }:

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

  home.username = username;
  home.homeDirectory = "/home/${username}";

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
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
