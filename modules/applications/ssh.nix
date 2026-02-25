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
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG/wHEHpwkF1VwCS/MxZf2cvECIeUHdbiLjO1J1jz0LL pascal@lenovo"
        ];

        services.avahi = {
            enable = true;
            nssmdns4 = true;
            openFirewall = true;
            publish = {
                enable = true;
                addresses = true;
                domain = true;
            };
        };

        services.openssh = {
            enable = true;
            settings = {
                PasswordAuthentication = false;
                PermitRootLogin = "no";
                StrictModes = true;
            };
        };
    };
}
