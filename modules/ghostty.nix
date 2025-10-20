{ pkgs, username, lib, config, ... }:

{
    config = lib.mkMerge [
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
                };
            };
        };
        }

        {
        home-manager.users.${username} = lib.mkIf config.mySystem.desktop.niri.enable {
            programs.ghostty.settings.background-opacity = 0.85;
        };
        }
    ];
}
