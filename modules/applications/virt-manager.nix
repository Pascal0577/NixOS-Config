{ pkgs, username, config, lib, ... }:

{
    options.mySystem.applications.virt-manager = {
        enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = "Whether to enable my virt-manager module";
        };

        blacklistNvidia = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Whether to blacklist nvidia drivers to set up PCI passthrough";
        };
    };

    config = lib.mkIf config.mySystem.applications.virt-manager.enable {
        programs.virt-manager.enable = true;

        users.groups.libvirtd.members = [ "${username}" ];

        environment.systemPackages = [ pkgs.qemu ];

        virtualisation.libvirtd = {
            enable = true;
            qemu = {
                package = pkgs.qemu_kvm;
                swtpm.enable = true;  # TPM emulation for Windows 11
            };
        };

        virtualisation.spiceUSBRedirection.enable = true;

        users.users.${username}.extraGroups = [ "libvirtd" ];

        home-manager.users.${username}.dconf.settings = {
            "org/virt-manager/virt-manager/connections" = {
                autoconnect = [ "qemu:///system" ];
                uris = [ "qemu:///system" ];
            };
        };

        boot = lib.mkIf config.mySystem.applications.virt-manager.blacklistNvidia {
            blacklistedKernelModules = [ "nouveau" "nvidia" ];

            initrd.kernelModules = [
                "vfio_pci"
                "vfio"
                "vfio_iommu_type1"
            ];

            kernelParams = [
                "intel_iommu=on"
                "iommu=pt"
            ];

            extraModprobeConfig = ''
                options vfio-pci ids=10de:28e1,10de:22be
            '';
        };
    };
}
