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
        base16Scheme = "${pkgs.base16-schemes}/share/themes/valua.yaml";
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
            package = lib.mkDefault pkgs.bibata-cursors;
            name = "Bibata-Modern-Ice";
            size = 32;
        };

        icons = {
            enable = true;
            package = pkgs.papirus-icon-theme;
            dark = "Papirus-Dark";
            light = "Papirus-Light";
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

            nixvim = {
                transparentBackground.numberLine = true;
                transparentBackground.signColumn = true;
            };
        };

        dconf.settings."org/gnome/desktop/interface" = {
            color-scheme = lib.mkForce "prefer-dark";
            font-antialiasing = lib.mkDefault "standard";
            font-hinting = lib.mkDefault "full";
        };
    };
}
