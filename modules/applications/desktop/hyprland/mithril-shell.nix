{ username, inputs, config, lib, ... }:

{
    options.mySystem.desktop.hyprland.mithril-shell.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable my mithril-shell module";
    };

    config = lib.mkIf config.mySystem.desktop.hyprland.mithril-shell.enable {
        home-manager.users.${username} = {
            imports = [ inputs.mithril-shell.homeManagerModules.default ];

            services.mithril-shell = {
                enable = true;
                integrations.hyprland.enable = true;
            };
        };
    };
}
