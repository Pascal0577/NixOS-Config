{ config, lib, ... }:

{
    options.mySystem = {
        desktop = {
            niri = {
                enable = lib.mkEnableOption "Niri Window Manager";
                noctalia.enable = lib.mkEnableOption "Noctalia shell for Niri";
                blur.enable = lib.mkEnableOption "Build Niri with experimental blur";
                walker.enable = lib.mkEnableOption "Use walker app launcher";
                vicinae.enable = lib.mkEnableOption "Use vicinae launcher";
            };
            gnome = {
                enable = lib.mkEnableOption "GNOME Desktop Environment";
                yaru.enable = lib.mkEnableOption "Yaru Shell theme for GNOME";
            };
            kde.enable = lib.mkEnableOption "KDE Plasma Desktop Environment";
        };
        neovim = {
            enable = lib.mkEnableOption "Neovim editor and support";
            ghostty-theme.enable = lib.mkEnableOption "Neovim theme to match default Ghostty theme";
            nord-theme.enable = lib.mkEnableOption "Nord theme for Neovim.";
        };
        nvidia.enable = lib.mkEnableOption "Enable support for my Nvidia + Intel laptop";
        secure-boot.enable = lib.mkEnableOption "Secure boot support via lanzaboote";
    };
}
