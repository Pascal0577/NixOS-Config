{ pkgs, config, lib, ... }:

{
    options.mySystem.applications.kmscon.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable my kmscon module";
    };

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
