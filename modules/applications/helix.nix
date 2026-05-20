{ lib, config, username, pkgs, ... }:

{
    options.mySystem.applications.helix.enable = lib.mkEnableOption "Helix module";

    config = lib.mkIf config.mySystem.applications.helix.enable {
        environment.sessionVariables = {
            COLORTERM = "truecolor";
            EDITOR = "hx";
        };
        home-manager.users.${username} = {
            stylix.targets.helix.enable = true;
            programs.helix = {
                enable = true;
                defaultEditor = true;
                extraPackages = [ pkgs.nixd ];
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
                languages = {
                    language = map (l: {
                        name = "${l}";
                        indent = {
                            tab-width = 4;
                            unit = "    ";
                        };
                    }) [ "nix" "zig" "bash" ];
                };
            };
        };
    };
}
