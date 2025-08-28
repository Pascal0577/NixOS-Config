{ pkgs, username, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
    packages = with pkgs; [

    ];

    file = {

    };

    sessionVariables = {
    };
  };

  programs = {
    home-manager.enable = true;
    mangohud.enable = true;
  };
}
