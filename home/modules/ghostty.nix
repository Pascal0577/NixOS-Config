{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ghostty
  ];

  programs.ghostty = {
    enable = true;
    settings = {
      command = "zsh";
      window-height = 35;
      window-width = 120;
    };
  };

  #home.file = {
  #   ".config/ghostty/config".text = ''
  #     command = zsh
  #     window-height = 35
  #     window-width = 120
  #   '';
  #};
}
