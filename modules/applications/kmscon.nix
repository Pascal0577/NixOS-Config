{ pkgs, config, lib, ... }:

{
    options.applications.kmscon.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable my kmscon module";
    };

    config = lib.mkIf config.applications.kmscon.enable {
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
