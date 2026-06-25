{ config, lib, username, ... }:

{
    config = lib.mkIf (config.mySystem.applications.terminal.choice == "kitty") {
        home-manager.users.${username} = {
            stylix.targets.kitty.enable = true;
            programs.kitty.enable = true;
        };
    };
}
