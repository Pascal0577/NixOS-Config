{ pkgs, username, config, lib, ... }:
let
    discord = config.mySystem.applications.discord;
in
{
    options.mySystem.applications.zed.enable =
        lib.mkEnableOption "Zed editor";

    config = lib.mkIf config.mySystem.applications.zed.enable {
        stylix.targets.zed.enable = true;
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
                scroll_beyond_last_line = "off";
                scrollbar.show = "never";
                relative_line_numers = "enabled";

                lsp = {
                    nixd.binary.path_lookup = true;
                    nil.binary.path_lookup = true;
                    zls.binary.path_lookup = true;
                    discord_presence = lib.mkIf discord.enable {
                        initialization_options = {
                            application_id = 1263505205522337886;
                            base_icons_url = "https://raw.githubusercontent.com/xhyrom/zed-discord-presence/main/assets/icons/";
                            state = "Working on {filename}";
                            details = "In {workspace}";

                            large_image = "{base_icons_url}/{language:lo}.png";
                            large_text = "{language:u}";

                            small_image = "{base_icons_url}/zed.png";
                            small_text = "Zed";

                            git_integration = true;
                        };
                    };
                };
            };
        };
    };
}
