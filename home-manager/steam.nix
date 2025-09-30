{ pkgs, ... }:

{
  packages = with pkgs; [
    steam
  ];

  programs.steam.enable = true;
  programs.mangohud.enable = true;
}
