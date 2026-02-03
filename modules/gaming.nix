{ pkgs, username, ... }:

{
    environment.systemPackages = with pkgs; [
        heroic
        prismlauncher
    ];

    programs.gamemode = {
        enable = true;
        settings.general.renice = 10;
    };

    home-manager.users.${username} = {
        programs.mangohud = {
            enable = true;
            settings.preset = 3;
        };
    };
}
