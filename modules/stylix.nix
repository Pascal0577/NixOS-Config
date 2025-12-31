{ pkgs, inputs, username, ... }:
{
    imports = [
        inputs.stylix.nixosModules.stylix
    ];

    stylix = {
        enable = true;
        autoEnable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
        image = ../nord-arctic-fox.png;

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
            package = pkgs.bibata-cursors;
            name = "Bibata-Modern-Ice";
            size = 24;
        };

        icons = {
            enable = true;
            package = pkgs.papirus-nord;
            dark = "Papirus-Dark";
        };

        targets = {
        };
    };

    home-manager.users.${username} = {
        stylix.targets = {
            noctalia-shell.enable = false;
            nixvim.enable = false;
            zen-browser.profileNames = [ "pascal" ];
            zen-browser.enable = false;
        };
    };
}
