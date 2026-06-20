{ username, config, lib, ... }:

{
    config = lib.mkIf (config.mySystem.applications.launcher.choice == "fuzzel") {
        mySystem.applications.launcher.command = "fuzzel";

        home-manager.users.${username} = {
            stylix.targets.fuzzel.enable = true;
            programs.fuzzel = {
                enable = true;
                settings = {
                    main = {
                        terminal = "${config.mySystem.applications.terminal.openWindow}";
                        layer = "overlay";
                    };
                    border.width = 4;
                };
            };
        };
    };
}
