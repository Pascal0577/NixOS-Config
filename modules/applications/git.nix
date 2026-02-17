{ pkgs, username, config, lib, ... }:

{
    options.mySystem.applications.git.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable my Git module";
    };

    config = lib.mkIf config.mySystem.applications.git.enable {
        environment.systemPackages = [ pkgs.gh ];
        home-manager.users.${username}.programs.git.enable = true;
    };
}
