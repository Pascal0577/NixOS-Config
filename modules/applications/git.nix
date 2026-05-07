{ pkgs, config, lib, username, ... }:

{
    options.mySystem.applications.git.enable =
        lib.mkEnableOption "Git module" // { default = true; };

    config = lib.mkIf config.mySystem.applications.git.enable {
        environment.systemPackages = [ pkgs.gh ];

        home-manager.users.${username}.programs.git = {
            enable = true;
            settings = {
                user.email = "181921662+Pascal0577@users.noreply.github.com";
                user.name = "Pascal0577";
            };
        };
    };
}
