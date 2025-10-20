{ pkgs, username, hostname, ... }:

{
    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        trusted-users = [ "${username}" ];
    };

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

    networking.hostName = hostname;
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "America/Chicago";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    systemd.user.extraConfig = ''
        DefaultTimeoutStopSec=10s
    '';

    zramSwap.enable = true;

    users.users.${username} = {
        isNormalUser = true;
        description = "Pascal";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
            home-manager
            nh
        ];
    };

    services.power-profiles-daemon.enable = true;

    security.rtkit.enable = true;
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "25.05";
}
