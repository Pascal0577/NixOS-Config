{ lib, config, username, pkgs, ... }:

{
    options.mySystem.applications.helix.enable = lib.mkEnableOption "helix";

    config = lib.mkIf config.mySystem.applications.helix.enable {
        home-manager.users.${username} = {
            programs.helix = {
                enable = true;
                extraPackages = with pkgs; [
                    nixd
                    nixfmt
                    zls
                    bash-language-server
                ];
                settings = {
                    editor = {
                        line-number = "relative";
                        indent-guides = {
                            render = true;
                            character = "┊";
                        };
                        cursor-shape = {
                            normal = "block";
                            insert = "bar";
                            select = "underline";
                        };
                    };
                };
            };
        };
    };
}
