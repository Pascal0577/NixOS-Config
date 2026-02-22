{ lib, config, username, pkgs, ... }:

{
    options.mySystem.applications.helix.enable = lib.mkEnableOption "helix";

    config = lib.mkIf config.mySystem.applications.helix.enable {
        home-manager.users.${username} = {
            programs.helix = {
                enable = true;
                extraPackages = with pkgs; [
                    nixd
                    zls
                    bash-language-server
                ];
            };
        };
    };
}
