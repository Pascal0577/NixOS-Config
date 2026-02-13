{ pkgs, username, config, lib, ... }:

{
    options.desktop.gnome.paperwm.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable my PaperWM module";
    };

    config = lib.mkIf config.desktop.gnome.paperwm.enable {
        environment.systemPackages = with pkgs; [
            gnomeExtensions.paperwm
        ];

        home-manager.users.${username} = {
            dconf.settings = {
                "org/gnome/shell" = {
                    enabled-extensions = with pkgs.gnomeExtensions; [
                        paperwm.extensionUuid
                    ];
                };

                "org/gnome/shell/extensions/paperwm" = {
                    animation-time = 0.2;
                    default-focus-mode = 0; # Edge, vs center or default
                    disable-topbar-styling = true;
                    edge-preview-enable = true;
                    edge-preview-scale = 0.25;
                    edge-preview-timeout = 0;
                    edge-preview-timeout-enable = true;
                    horizontal-margin = 10;
                    vertical-margin = 10;
                    vertical-margin-bottom = 10;
                    window-gap = 10;
                    use-default-background = true;
                    show-workspace-indicator = false;
                    show-window-position-bar = false;
                    show-open-position-icon = true;
                    show-focus-mode-icon = true;
                    selection-border-size = 5;
                    selection-border-radius-top = 10;
                    selection-border-radius-bottom = 10;
                };

                "org/gnome/shell/extensions/paperwm/keybindings" = {
                    close-window = ["<Super>q"];
                    move-left = [
                        "<Shift><Super>Left"
                        "<Shift><Super>a"
                    ];
                    move-right = [
                        "<Shift><Super>Right"
                        "<Shift><Super>d"
                    ];
                    move-up = [
                        "<Control><Super>Up"
                        "<Control><Super>w"
                    ];
                    move-down = [
                        "<Control><Super>Down"
                        "<Control><Super>s"
                    ];
                    switch-left = [
                        "<Super>Left"
                        "<Super>a"
                    ];
                    switch-right = [
                        "<Super>Right"
                        "<Super>d"
                    ];
                    move-down-workspace = [
                        "<Shift><Super>Down"
                        "<Shift><Super>s"
                    ];
                    move-up-workspace = [
                        "<Shift><Super>Up"
                        "<Shift><Super>w"
                    ];
                    move-to-workspace-down = [
                        "<Super>Down"
                        "<Super>s"
                    ];
                    move-to-workspace-up = [
                        "<Super>Up"
                        "<Super>w"
                    ];
                    switch-monitor-above = [""];
                    switch-monitor-below = [""];
                    switch-monitor-left = [""];
                    switch-monitor-right = [""];
                };
            };
        };
    };
}
