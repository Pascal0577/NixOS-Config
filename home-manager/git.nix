{ pkgs, ... }:

{
    home.packages = with pkgs; [
        gh
    ];

    programs.git = {
        enable = true;
    };
}
