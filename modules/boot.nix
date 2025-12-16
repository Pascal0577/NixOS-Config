{ pkgs, inputs, ... }:

{
    imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
    boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        bootspec.enable = true;
        plymouth = {
            enable = true;
            theme = "bgrt";
        };


        lanzaboote = {
            enable = true;
            pkiBundle = "/var/lib/sbctl/";
        };

        # Enable "Silent boot"
        consoleLogLevel = 4;
        initrd = {
            verbose = false;
            systemd.enable = true;
        };

        kernelParams = [
            "quiet"
            "splash"
            "nowatchdog"
            "boot.shell_on_fail"
            "udev.log_priority=3"
            "rd.systemd.show_status=auto"
            "rcupdate.rcu_expedited=1"
            "page_alloc.shuffle=1"
        ];

        loader = {
            timeout = 0;
            efi.canTouchEfiVariables = true;
        };
    };
}
