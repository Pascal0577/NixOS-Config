{ inputs, config, lib, ... }:

{
    options.mySystem.impermanence.enable = lib.mkEnableOption "impermanence";

    imports = [ inputs.impermanence.nixosModules.impermanence ];

    config = lib.mkIf config.mySystem.impermanence.enable {
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
