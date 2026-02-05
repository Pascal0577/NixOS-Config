{ pkgs, username, ... }:
let
    heroic-old = pkgs.callPackage ../packages/heroic_2_18 {};
in
{
    environment.systemPackages = with pkgs; [
        heroic-old
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
