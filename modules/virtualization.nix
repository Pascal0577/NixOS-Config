{ username, pkgs, ... }:

{
    programs.virt-manager.enable = true;

    users.groups.libvirtd.members = ["${username}"];

    virtualisation.libvirtd = {
        enable = true;
        qemu = {
            package = pkgs.qemu_kvm;
            swtpm.enable = true;  # TPM emulation for Windows 11
        };
    };

    virtualisation.spiceUSBRedirection.enable = true;

    users.users.${username}.extraGroups = [ "libvirtd" ];

    # boot = {
    #     blacklistedKernelModules = [ "nouveau" "nvidia" ];

    #     initrd.kernelModules = [
    #         "vfio_pci"
    #         "vfio"
    #         "vfio_iommu_type1"
    #     ];            

    #     kernelParams = [
    #         "intel_iommu=on"
    #         "iommu=pt"
    #     ];

    #     extraModprobeConfig = ''
    #         options vfio-pci ids=10de:28e1,10de:22be
    #     '';
    # };

    home-manager.users.${username} = {
        dconf.settings = {
            "org/virt-manager/virt-manager/connections" = {
                autoconnect = ["qemu:///system"];
                uris = ["qemu:///system"];
            };
        };
   };
}
