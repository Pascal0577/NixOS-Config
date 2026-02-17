{ config, lib, ... }:

{
    options.mySystem.applications.ssh.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable my SSH module";
    };

    config = lib.mkIf config.mySystem.applications.ssh.enable {
        services.openssh = {
            enable = true;
            startWhenNeeded = true;
            settings = {
                UseDns = true;
                PasswordAuthentication = false;
                PermitRootLogin = "no";
                StrictModes = true;
            };
        };
    };
}
