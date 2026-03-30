{ username, lib, ... }:

{
    options.mySystem.server.enable = lib.mkEnableOption ''
        Whether to use system as a server.
        Disable graphical apps, pipewire, etc
    '';

    config = {
        nixpkgs.config.allowUnfree = true;
        system.stateVersion = "26.05";

        nix.settings = {
            experimental-features = [ "nix-command" "flakes" ];
            trusted-users = [ "${username}" ];
        };

        security = {
            # Disable sudo
            run0.enableSudoAlias = true;
            polkit.enable = true;
            sudo.enable = false;
            wrappers = {
                su.enable = false;
                sudoedit.enable = false;
                sg.enable = false;
                fusermount.enable = false;
                fusermount3.enable = false;
                pkexec.setuid = lib.mkForce false;
                newgrp.setuid = lib.mkForce false;
                mount.enable = false;
                umount.enable = false;
            };
        };

        systemd = {
            # If a service has tried to stop for longer than 10s 
            # something has gone wrong and it should be force stopped
            user.extraConfig = "DefaultTimeoutStopSec=10s";
            settings.Manager = {
                DefaultTimeoutStopSec = "10s";
            };

            services = {
                "serial-getty@".enable = false;
                NetworkManager-wait-online.enable = false;
            };
        };
    };
}
