{ lib, ... }:

{
    security = {
        # Disable sudo
        run0.enableSudoAlias = true;
        polkit.enable = true;
        sudo.enable = false;
        wrappers = {
            su.enable = lib.mkForce false;
            sudoedit.enable = lib.mkForce false;
            sg.enable = lib.mkForce false;
            fusermount.enable = lib.mkForce false;
            fusermount3.enable = lib.mkForce false;
            pkexec.setuid = lib.mkForce false;
            newgrp.setuid = lib.mkForce false;
            # `mount` Needed for `fileSystems.options`
            mount.enable = lib.mkForce false;
            # Optional: if you disable mount, disable umount as well
            umount.enable = lib.mkForce false;
        };
    };
}
