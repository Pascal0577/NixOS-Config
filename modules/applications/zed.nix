{ pkgs, username, config, lib, ... }:

{
    options.mySystem.applications.zed.enable =
        lib.mkEnableOption "Zed editor";

    config = lib.mkIf config.mySystem.applications.zed.enable {
        home-manager.users.${username}.programs.zed-editor = {
            enable = true;
            package = pkgs.zed-editor-fhs;
            extensions = [
                "zig"
                "nix"
                "discord-presence"
            ];
            extraPackages = with pkgs; [
                nil
                nixd
                zig_0_16
                zls_0_16
            ];
            userSettings = {
                helix_mode = true;
                buffer_font_family = "JetBrainsMono Nerd Font";

                lsp = {
                    nixd.binary.path_lookup = true;
                    nil.binary.path_lookup = true;
                    zls.binary.path_lookup = true;
                };
            };
        };
    };
}
