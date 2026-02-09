{ username, ... }:

{
    terminalOpenWindow = "alacritty";
    home-manager.users.${username} = {
        programs.alacritty.enable = true;
    };
}
