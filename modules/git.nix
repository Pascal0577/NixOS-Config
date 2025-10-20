{ pkgs, username, ... }:

{
    environment.systemPackages = with pkgs; [
        gh
    ];

    home-manager.users.${username} = {
        programs.git = {
            enable = true;
        };
    };
}
