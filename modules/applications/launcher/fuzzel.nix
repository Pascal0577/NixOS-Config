{ username, config, lib, pkgs, ... }:

{
    options.mySystem.applications.launcher.fuzzel.enable =
        lib.mkEnableOption "Fuzzel launcher module";

    config = lib.mkIf config.mySystem.applications.launcher.fuzzel.enable {
        mySystem.applications.launcher = {
            package = pkgs.fuzzel;
            command = "fuzzel";
        };

        home-manager.users.${username} = {
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
