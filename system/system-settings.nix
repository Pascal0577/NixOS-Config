{ pkgs, username, hostname, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.pathsToLink = [ "/share/zsh" ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    # For nix-ld
    LD_LIBRARY_PATH = "/run/current-system/sw/share/nix-ld/lib";
  };

  zramSwap.enable = true;

  programs.nix-ld = {
    enable  = true;
    package = pkgs.nix-ld;
    libraries = with pkgs; [
      libxcrypt
      libxcrypt-legacy
      libffi
      libyaml
      icu
    ];
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    plymouth = {
      enable = true;
      theme = "bgrt";
      themePackages = with pkgs; [
        # (adi1090x-plymouth-themes.override {
        #   selected_themes = [ "rings" ];
        # })
      ];
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

  # Enable networking
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

  security.rtkit.enable = true;

  services = {
    printing.enable = true;
    openssh.enable = true;

    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
      xkb = {
        layout = "us";
        variant = "";
      };
      # autoLogin is really janky and bad right now.
      # displayManager.autoLogin = {
      #   enable = true;
      #   user = "${username}";
      # };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  hardware = {
    bluetooth.enable = true;
    graphics.enable = true;
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "Pascal";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      home-manager
    ];
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
