{ config, lib, username, ... }:

{
    config = lib.mkIf (config.mySystem.applications.terminal.choice == "kitty") {
        mySystem.applications.terminal = {
            openWindow = "kitty";
            runCommand = "kitty -e";
        };

        home-manager.users.${username} = {
            stylix.targets.kitty.enable = true;
            programs.kitty.enable = true;
        };
    };
}
