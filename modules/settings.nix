{ config, lib, ... }:

{
    options.mySystem = {
        desktop = {
            niri = {
                enable = lib.mkEnableOption "Niri Window Manager";
                noctalia.enable = lib.mkEnableOption "Noctalia shell for Niri";
                blur.enable = lib.mkEnableOption "Build Niri with experimental blur";
            };
            gnome = {
                enable = lib.mkEnableOption "GNOME Desktop Environment";
                yaru.enable = lib.mkEnableOption "Yaru Shell theme for GNOME";
            };
            kde.enable = lib.mkEnableOption "KDE Plasma Desktop Environment";
        };
        obs-optimization.enable = lib.mkEnableOption "Compile OBS with aggressive optimization flags";
        neovim.enable = lib.mkEnableOption "Neovim editor and support";
        nvidia.enable = lib.mkEnableOption "Enable support for my Nvidia + Intel laptop";
        secure-boot.enable = lib.mkEnableOption "Secure boot support via lanzaboote";
    };
}
