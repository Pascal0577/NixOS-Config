{ pkgs, username, config, lib, ... }:

{
    options.applications.git.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable my Git module";
    };

    config = lib.mkIf config.applications.git.enable {
        environment.systemPackages = [ pkgs.gh ];
        home-manager.users.${username}.programs.git.enable = true;
    };
}
