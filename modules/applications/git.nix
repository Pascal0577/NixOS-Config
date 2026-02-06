{ pkgs, username, ... }:

{
    environment.systemPackages = [ pkgs.gh ];
    home-manager.users.${username}.programs.git.enable = true;
}
