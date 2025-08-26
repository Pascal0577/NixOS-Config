{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    git
  ];

  programs.git = {
    enable = true;

    userName = "Pascal";
    userEmail = "pascalthederg@gmail.com";
  };
}
