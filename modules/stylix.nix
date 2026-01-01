{ pkgs, inputs, username, lib, ... }:
{
    imports = [
        inputs.stylix.nixosModules.stylix
    ];

    stylix = {
        enable = true;
        autoEnable = false;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
        image = ../wallpapers/nord-arctic-fox.png;

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
            size = 24;
        };

        icons = {
            enable = true;
            package = pkgs.papirus-nord;
            dark = "Papirus-Dark";
            light = "Papirus";
        };

        targets = {
            kmscon.enable = true;
        };
    };

    home-manager.users.${username} = {
        stylix.targets = {
            nixvim.enable = false;
            zen-browser.profileNames = [ "pascal" ];
            zen-browser.enable = false;
            mangohud.enable = true;
            ghostty.enable = true;
        };

        dconf.settings."org/gnome/desktop/interface" = {
            gtk-theme = "Nordic-standard-buttons";
            accent-color = "blue";
            color-scheme = "prefer-dark";
            font-antialiasing = "standard";
            font-hinting = "full";
            font-name = "Ubuntu Sans 12";
            monospace-font-name = "Ubuntu Sans Mono 12";
            icon-theme = "Papirus-Dark";
        };

        dconf.settings."org/gnome/desktop/wm/preferences" = {
            theme = "Nordic-standard-buttons";
        };
    };
}
