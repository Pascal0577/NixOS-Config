{ lib, ... }: 

{
    # https://github.com/V4bel/dirtyfrag
    boot.blacklistedKernelModules = [  "esp6" "esp4" "rxrpc" ];

    security = {
        # Disable sudo
        run0.enable = true;
        run0.enableSudoAlias = true;
        polkit.enable = true;
        sudo.enable = false;
        wrappers = {
            su.enable = false;
            sudoedit.enable = false;
            sg.enable = false;
            fusermount.enable = false;
            # fusermount3.enable = false;
            pkexec.setuid = lib.mkForce false;
            newgrp.setuid = lib.mkForce false;
            mount.enable = false;
            umount.enable = false;
            chsh.enable = false;
        };
    };
}

