{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
      yaru-theme
      ubuntu-sans
      showtime
    ];

    fonts.fontconfig.enable = true;

    services.displayManager.gdm = {
      enable = true;
      wayland = true;
    };

    services.desktopManager.gnome.enable = true;

    programs.dconf.profiles.gdm.databases = [{
      settings = {
        "org/gnome/desktop/peripherals/keyboard" = {
          numlock-state = true;
        };

        "org/gnome/desktop/sound".theme-name = "Yaru";

        "org/gnome/desktop/interface" = {
          show-battery-percentage = true;
          color-scheme = "prefer-dark";
          accent-color = "pink";
	        font-antialiasing = "standard";
	        font-hinting = "full";
	        font-name = "Ubuntu Sans 12";
	        monospace-font-name = "Ubuntu Sans Mono 12";
	        icon-theme = "Yaru";
	        clock-format = "12h";
	        cursor-theme = "Yaru";
        };
      };
    }];
  
    environment.gnome.excludePackages = (with pkgs; [
      yelp             epiphany
      atomix           cheese
      epiphany         evince
      geary            gedit 
      gnome-console    gnome-text-editor
      gnome-maps       gnome-clocks 
      gnome-music      simple-scan
      gnome-tour       gnome-photos
      gnome-contacts   gnome-weather
      gnome-calendar   gnome-connections
      snapshot         hitori
      iagno            tali
      loupe            totem
    ]);
}
