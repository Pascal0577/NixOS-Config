{ inputs, config, ... }:

{
    imports = [
        inputs.niri.homeModules.niri
    ];

    programs.niri = {
        binds = with config.lib.niri.actions; {
            "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
            "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";

            # Focusing columns
            "Mod+Left".action = focus-column-left;
            "Mod+A".action = focus-column-left;
            "Mod+Right".action = focus-column-right;
            "Mod+D".action = focus-column-right;
            "Mod+Down".action = focus-window-or-workspace-down;
            "Mod+S".action = focus-window-or-workspace-down;
            "Mod+Up".action = focus-window-or-workspace-up;
            "Mod+W".action = focus-window-or-workspace-up;

            # Moving columns
            "Mod+Shift+Left".action = move-column-left;
            "Mod+Shift+A".action = move-column-left;
            "Mod+Shift+Right".action = move-column-right;
            "Mod+Shift+D".action = move-column-right;
            "Mod+Shift+Down".action = move-window-down-or-to-workspace-down;
            "Mod+Shift+S".action = move-window-down-or-to-workspace-down;
            "Mod+Shift+Up".action = move-window-up-or-to-workspace-up;
            "Mod+Shift+W".action = move-window-up-or-to-workspace-up;

            "Mod+.".action = consume-or-expel-window-right;
            "Mod+,".action = consume-or-expel-window-left;
            
            "Mod+Minus".action = set-column-width "-10%";
            "Mod+Plus".action = set-column-width "+10%";

            "Mod+Esc".action = toggle-window-floating;
            
            "Mod+F".action = maximize-column;
            "Mod+C".action = center-column;
            "Mod+O".action = toggle-overview;
        };
    };
}
