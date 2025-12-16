{ pkgs, username, lib, config, ... }:

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
            systemd.enable = true;
            settings = {
                confirm-close-surface = false;
                quit-after-last-window-closed = true;
                quit-after-last-window-closed-delay = "1h";
                theme = "noctalia";
            };
        };
    };
}
