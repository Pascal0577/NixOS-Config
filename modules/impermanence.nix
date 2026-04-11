{ inputs, config, lib, username, ... }:

{
    options.mySystem.impermanence.enable = lib.mkEnableOption "Impermanence";

    imports = [ inputs.impermanence.nixosModules.impermanence ];

    config = lib.mkIf config.mySystem.impermanence.enable {
        users.users.${username}.hashedPasswordFile = "/nix/persist/passwords/pascal";
        fileSystems."/nix/persist".neededForBoot = true;
        boot.initrd.systemd.services.rollback = {
            description = "Rollback root ZFS dataset";
            wantedBy = [ "initrd.target" ];
            # have "zfs-import-zroot.service" just in case
            after = [ "zfs-import-zroot.service" "zfs-import.service" ];
            before = [ "sysroot.mount" ];
            unitConfig.DefaultDependencies = "no";
            serviceConfig.Type = "oneshot";
            script = ''
                zfs rollback -r zroot/local/root@blank
            '';
        };

        environment.persistence."/nix/persist" = {
            enable = true;
            hideMounts = true;
            directories = [
                "/var/log"
                "/var/lib/bluetooth"
                "/var/lib/nixos"
                "/var/lib/libvirt"
                "/var/lib/sbctl"
                "/var/lib/systemd"
                "/etc/mullvad-vpn"
                "/var/db/sudo/lectured"
                "/etc/NetworkManager/system-connections"
                "/etc/ssh"
            ];
            files = [
                "/etc/machine-id"
            ];
        };
    };
}
