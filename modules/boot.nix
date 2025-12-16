{ pkgs, ... }:

{
    boot = {
        kernelPackages = pkgs.linuxPackages_lqx;
        plymouth = {
            enable = true;
            theme = "bgrt";
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
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };
    };
}
