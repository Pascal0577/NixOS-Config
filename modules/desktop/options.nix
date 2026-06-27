{ lib, ... }:

{
    options.mySystem.desktop.choice = lib.mkOption {
        type = lib.types.enum [ "niri" "gnome" "hyprland" "oxwm" "cosmic" "none" ];
        default = "none";
    };
}
