{ pkgs, username, ... }:

{
  imports = [ 
    ./home/zen-browser.nix
    ./home/neovim.nix
    ./home/git.nix
    ./home/shell.nix
    ./home/ghostty.nix
    ./home/discord.nix
    ./home/obs-studio.nix
    ./home/fastfetch.nix
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
