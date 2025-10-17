{ pkgs, ... }:

{
    home.packages = with pkgs; [
        ghostty
    ];

    programs.ghostty = {
        enable = true;
        enableZshIntegration = true;
        settings = {
            confirm-close-surface = false;
        };
    };
}
