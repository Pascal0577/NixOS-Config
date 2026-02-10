{ username, ... }:

{
    launcherCommand = "fuzzel";
    home-manager.users.${username} = {
        programs.fuzzel = {
            enable = true;
              main = {
                    # terminal = "${pkgs.foot}/bin/foot";
                    layer = "overlay";
              };
              colors.background = "ffffffff";
        };
    };
}
