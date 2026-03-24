{ pkgs, config, lib, ... }:

{
    options.mySystem.applications.kmscon.enable =
        lib.mkEnableOption "KMSCON console module" // { default = true; };        

    config = lib.mkIf config.mySystem.applications.kmscon.enable {
        services.kmscon = {
            enable = true;
            hwRender = true;
            fonts = [{
                name = "JetBrainsMono Nerd Font";
                package = pkgs.nerd-fonts.jetbrains-mono;
            }];
        };
    };
}
