{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.user-themes
    gnomeExtensions.clipboard-history
    celluloid
  ];

  home.pointerCursor = {
    package = pkgs.yaru-theme;
    name = "Yaru";
    size = 32;
  };

  gtk = {
    enable = true;
    cursorTheme = {
      size = 24;
      package = pkgs.yaru-theme;
      name = "Yaru";
    };
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          blur-my-shell.extensionUuid
          dash-to-dock.extensionUuid
          user-themes.extensionUuid
          clipboard-history.extensionUuid
        ];
        favorite-apps = [
          # .desktop files can be found in "/run/current-system/sw/share/applications/"
          "com.mitchellh.ghostty.desktop"
          "zen-beta.desktop"
          "vesktop.desktop"
          "org.gnome.Nautilus.desktop"
        ];
      };

      "org/gnome/nautilus/preferences" = {
        click-policy = "single";
      };

      # I'll re-enable this when VRR on GNOME doesn't suck turbo ass
      # "org/gnome/mutter" = {
      #   experimental-features = [
      #     "variable-refresh-rate"
      #   ];
      # };

      "org/gnome/shell/extensions/user-theme".name = "Yaru-dark";

      "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
        static-blur = false;
        blur = false;
      };

      "org/gnome/shell/extensions/blur-my-shell/panel" = {
        override-background = false;
        unblur-in-overview = false;
        static-blur = false;
      };

      "org/gnome/shell/extensions/dash-to-dock" = {
        dock-position = "RIGHT";
        extend-height = true;
        scroll-action = "switch-workspace";
        middle-click-action = "launch";
        custom-theme-shrink = true;
        transparency-mode = "FIXED";
        background-opacity = 0.90;
      };

      "org/gnome/desktop/interface" = {
        show-battery-percentage = true;
        color-scheme = "prefer-dark";
        accent-color = "orange";
        font-antialiasing = "standard";
        font-hinting = "full";
        font-name = "Ubuntu Sans 12";
        monospace-font-name = "Ubuntu Sans Mono 12";
        icon-theme = "Yaru";
        clock-format = "12h";
        # cursor-theme = "Yaru";
      };

      "org/gnome/desktop/sound".theme-name = "Yaru";

      "org/gnome/desktop/wm/preferences" = {
        resize-with-right-button = true;
        auto-raise = true;
        auto-raise-delay = 0;
        focus-mode = "sloppy";
      };

      "org/gnome/desktop/datetime".automatic-timezone = true;

      "org/gnome/login-screen" = {
    	  enable-fingerprint-authentication = false;
        enable-smartcard-authentication = false;
      };
    };
  };
}
