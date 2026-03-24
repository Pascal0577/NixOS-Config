{ pkgs, config, lib, ... }:

{
    options.mySystem.applications.git.enable =
        lib.mkEnableOption "Git module" // { default = true; };

    config = lib.mkIf config.mySystem.applications.git.enable {
        environment.systemPackages = [ pkgs.gh ];
        programs.git.enable = true;
    };
}
