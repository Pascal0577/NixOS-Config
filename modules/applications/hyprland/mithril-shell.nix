{ username, inputs, ... }:

{
    home-manager.users.${username} = {
        imports = [ inputs.mithril-shell.homeManagerModules.default ];

        services.mithril-shell = {
            enable = true;
            integrations.hyprland.enable = true;
        };
    };
}
