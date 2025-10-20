{ pkgs, username, lib, ... }:

{
    environment = {
        sessionVariables = { TERMINAL="ghostty"; };
        systemPackages = [
            (pkgs.writeShellScriptBin "xdg-terminal-exec" ''
                exec "${lib.getExe pkgs.ghostty}" -- "$@"
            '')
        ];
    };

    home-manager.users.${username} = {
        programs.ghostty = {
            enable = true;
            enableZshIntegration = true;
            settings = {
                confirm-close-surface = false;
                background-opacity = 0.85;
            };
        };
    };
}
