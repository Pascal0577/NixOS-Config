{ pkgs, inputs, username, lib, ... }:
{
    imports = [
        inputs.stylix.nixosModules.stylix
    ];

    environment.systemPackages = [ pkgs.papirus-nord ];

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
            console.enable = true;
            nixos-icons.enable = true;
            gnome.enable = true;
            gtk.enable = true;
            qt.enable = true;
        };
    };

    home-manager.users.${username} = {
        stylix.targets = {
            zen-browser = {
                enable = true;
                profileNames = [ "pascal" ];
            };

            mangohud.enable = true;
            ghostty.enable = true;
            gnome.enable = true;
        };

        dconf.settings."org/gnome/desktop/interface" = {
            gtk-theme = "Nordic-standard-buttons";
            accent-color = lib.mkDefault "blue";
            color-scheme = lib.mkForce "prefer-dark";
            font-antialiasing = lib.mkDefault "standard";
            font-hinting = lib.mkDefault "full";
            font-name = lib.mkDefault "Ubuntu Sans 12";
            monospace-font-name = lib.mkDefault "Ubuntu Sans Mono 12";
            icon-theme = lib.mkDefault "Papirus-Dark";
        };

        dconf.settings."org/gnome/desktop/wm/preferences" = {
            theme = "Nordic-standard-buttons";
        };
    };
}
