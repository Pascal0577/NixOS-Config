{ pkgs, inputs, username, lib, ... }:
{
    imports = [
        inputs.stylix.nixosModules.stylix
    ];

    environment.systemPackages = with pkgs; [
        papirus-nord
        everforest-gtk-theme
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
        autoEnable = false;
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
            size = 24;
        };

        #icons = {
        #    enable = true;
        #    package = pkgs.papirus-nord;
        #    dark = "Papirus-Dark";
        #    light = "Papirus";
        #};

        targets = {
            kmscon.enable = true;
            console.enable = true;
            nixos-icons.enable = true;
            gnome.enable = true;
            gtk.enable = true;
            qt.enable = false;
        };
    };

    home-manager.users.${username} = {
        stylix.targets = {
            zen-browser = {
                enable = true;
                profileNames = [ "pascal" ];
            };

            mangohud.enable = true;
            ghostty.enable = false;
            gnome.enable = true;
            vicinae.enable = true;
            hyprland.enable = true;
            hyprpaper.enable = true;
            gtk.enable = true;
        };

        programs = {
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

            vesktop.vencord.settings.enabledThemes = [ "nordic.vencord.css" ];
        };

        dconf.settings."org/gnome/desktop/interface" = {
            gtk-theme = lib.mkForce "Everforest-Dark-Soft";
            accent-color = lib.mkDefault "blue";
            color-scheme = lib.mkForce "prefer-dark";
            font-antialiasing = lib.mkDefault "standard";
            font-hinting = lib.mkDefault "full";
            font-name = lib.mkDefault "Ubuntu Sans 12";
            monospace-font-name = lib.mkDefault "Ubuntu Sans Mono 12";
            icon-theme = lib.mkDefault "Papirus-Dark";
        };

        dconf.settings."org/gnome/desktop/wm/preferences" = {
            theme = "Everforest-Dark-Soft";
        };

        programs.ghostty.settings.theme = "Everforest";
    };
}
