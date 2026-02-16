{ lib, config, pkgs, username, ... }: 

{
    options.desktop.cosmic.cosmicOnNiri.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable the Niri compositor for the COSMIC session";
    };

    config = lib.mkIf config.desktop.config.cosmicOnNiri.enable {
        environment = {
            systemPackages = [
                (pkgs.callPackage ../../../../packages/cosmic-ext-niri/default.nix {})
            ];
            pathsToLink = [ "/share/wayland-sessions" ];
        };

        launcher = {
            command = "cosmic-launcher";
            package = pkgs.cosmic-launcher;
        };

        home-manager.users.${username} = {
            programs.niri.settings.layout.border = {
                color = lib.mkForce "#${config.desktop.cosmic.accentColor}";
            };
        };
    };
}
