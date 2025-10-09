{ pkgs, ... }:

{
    home.packages = with pkgs; [
        ghostty
    ];

    programs.ghostty = {
        enable = true;
        enableZshIntegration = true;
        settings = {
            command = "zsh";
            window-height = 35;
            window-width = 120;
        };
    };
}
