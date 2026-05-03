{ pkgs, username, config, lib, ... }:

{
    options.mySystem.applications.zed.enable =
        lib.mkEnableOption "Zed editor"
        // { default = !config.mySystem.server.enable; };

    config = lib.mkIf config.mySystem.applications.zed.enable {
        home-manager.users.${username}.programs.zed-editor = {
            enable = true;
            extensions = [
                "zig"
                "nix"
            ];
            extraPackages = with pkgs; [
                zed-zed-editor-fhs
                nixd
                zig_0_16
                zls_0_16
            ];
            userSettings = {
                helix_mode = true;
                buffer_font_family = "JetBrainsMono Nerd Font";
                theme = {
                    mode = "system";
                    light = "Everforest Light Soft (material)";
                    dark = "Everforest Dark Medium (regular)";
                };
            };
        };
    };
}
