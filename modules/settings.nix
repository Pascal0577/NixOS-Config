{ config, lib, ... }:

{
    options.mySystem = {
        desktop = {
            niri = {
                enable = lib.mkEnableOption "Niri Window Manager";
                noctalia.enable = lib.mkEnableOption "Noctalia shell for Niri";
            };
            gnome = {
                enable = lib.mkEnableOption "GNOME Desktop Environment";
                yaru-shell.enable = lib.mkEnableOption "Yaru Shell theme for GNOME";
            };
            kde.enable = lib.mkEnableOption "KDE Plasma Desktop Environment";
        };
        neovim.enable = lib.mkEnableOption "Neovim editor and support";
        nvidia.enable = lib.mkEnableOption "Enable support for my Nvidia + Intel laptop";
        secure-boot.enable = lib.mkEnableOption "Secure boot support via lanzaboote";
    };
}
