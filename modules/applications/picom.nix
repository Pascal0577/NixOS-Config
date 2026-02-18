{ lib, config, ... }:

{
    options.mySystem.applications.picom.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
    };

    config = lib.mkIf config.mySystem.applications.picom.enable {
        services.picom = {
            enable = true;
            fade = true;
            fadeSteps = [ 0.04 0.04 ];
            fadeDelta = 3;
            settings = {
                blur = {
                    method = "gaussian";
                    size = 10;
                    deviation = 5.0;
                };
            };
        };
    };
}
