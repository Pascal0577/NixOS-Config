{ config, lib, username, ... }:

{
    options.mySystem.applications.ssh.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable my SSH module";
    };

    config = lib.mkIf config.mySystem.applications.ssh.enable {
        users.users.${username}.openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMCi86K7NBo6vMNdGSItXFDthrLSx9Q0l9acqGlQdmoc pascal@nixos"
        ];
        services.avahi = {
            enable = true;
            nssmdns4 = true;
            publish = {
                enable = true;
                addresses = true;
                domain = true;
            };
        };
        services.openssh = {
            enable = true;
            settings = {
                UseDns = true;
                PasswordAuthentication = false;
                PermitRootLogin = "no";
                StrictModes = true;
            };
        };
    };
}
