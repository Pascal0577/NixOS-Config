{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    gh
  ];

  programs.git = {
    enable = true;
  };
}
