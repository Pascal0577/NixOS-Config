{ pkgs, inputs, username, lib, ... }:
{
    imports = [
        inputs.stylix.nixosModules.stylix
    ];

    fonts = {
        packages = with pkgs; [
            ubuntu-sans
            ubuntu-sans-mono
            noto-fonts-cjk-sans
        ];

        fontconfig = {
            enable = true;
            useEmbeddedBitmaps = true;
        };
    };

    stylix = {
        enable = true;
        autoEnable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-soft.yaml";
        image = ../../assets/flowers.png;

        fonts = {
            serif = {
                package = pkgs.ubuntu-sans;
                name = "Ubuntu Sans";
            };

            sansSerif = {
                package = pkgs.ubuntu-sans;
                name = "Ubuntu Sans";
            };

            monospace = {
                package = pkgs.nerd-fonts.jetbrains-mono;
                name = "JetBrainsMono Nerd Font";
            };

            emoji = {
                package = pkgs.noto-fonts-color-emoji;
                name = "Noto Color Emoji";
            };
        };

        cursor = {
            package = lib.mkDefault pkgs.everforest-cursors;
            name = "everforest-cursors";
            size = 32;
        };

        icons = {
            enable = true;
            package = pkgs.everforest-gtk-theme;
            dark = "Everforest-Dark";
            light = "Everforest-Light";
        };

        targets = {
            plymouth.enable = false;
            qt.enable = false;
        };
    };

    home-manager.users.${username} = {
        stylix.targets = {
            zen-browser = {
                enable = true;
                profileNames = [ "pascal" ];
            };

            nixvim.enable = false;
        };

        programs = {
            vesktop.vencord.themes.stylix = lib.mkAfter ''
                ::selection {
                    background-color: #7FBBB3;
                    color: #333C43;
                }
            '';

            nixvim = {
                colorschemes.everforest = {
                    enable = true;
                    settings = {
                        background = "soft";
                    };
                };

                performance.combinePlugins.standalonePlugins = [
                    pkgs.vimPlugins.everforest
                ];
            };
        };

        dconf.settings."org/gnome/desktop/interface" = {
            accent-color = lib.mkDefault "green";
            color-scheme = lib.mkForce "prefer-dark";
            font-antialiasing = lib.mkDefault "standard";
            font-hinting = lib.mkDefault "full";
        };
    };
}
