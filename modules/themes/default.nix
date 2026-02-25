{ pkgs, inputs, username, lib, config, stylix, ... }:
let
    inherit (lib) mkDefault mkForce;
in
{
    imports = [ stylix.nixosModules.stylix ];
    programs.dconf.enable = true;

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
        autoEnable = mkDefault true;

        fonts = {
            serif = {
                package = mkDefault pkgs.ubuntu-sans;
                name = mkDefault "Ubuntu Sans";
            };

            sansSerif = {
                package = mkDefault pkgs.ubuntu-sans;
                name = mkDefault "Ubuntu Sans";
            };

            monospace = {
                package = mkDefault pkgs.nerd-fonts.jetbrains-mono;
                name = mkDefault "JetBrainsMono Nerd Font";
            };

            emoji = {
                package = mkDefault pkgs.noto-fonts-color-emoji;
                name = mkDefault "Noto Color Emoji";
            };
        };

        targets = {
            plymouth.enable = false;
            qt.enable = false;
        };

        cursor = {
            package = mkDefault pkgs.bibata-cursors;
            name = mkDefault "Bibata-Modern-Ice";
            size = mkDefault 24;
        };

        icons = {
            enable = mkDefault true;
            package = mkDefault pkgs.papirus-icon-theme;
            dark = mkDefault "Papirus-Dark";
            light = mkDefault "Papirus-Light";
        };
    };

    home-manager.users.${username} = {          
        stylix.targets = {
            nixvim.enable = mkDefault false;
            zen-browser = {
                enable = true;
                profileNames = [ "pascal" ];
            };
        };

        dconf.settings."org/gnome/desktop/interface" = {
            color-scheme = mkForce "prefer-dark";
            font-antialiasing = mkDefault "standard";
            font-hinting = mkDefault "full";
        };
    };
}
