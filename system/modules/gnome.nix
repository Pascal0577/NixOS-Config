{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    yaru-theme
    ubuntu-sans
  ];

  # Enable the GNOME Desktop Environment.
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

      "org/gnome/shell/extensions/user-theme".name = "Yaru";

      "org/gnome/desktop/interface" = {
        show-battery-percentage = true;
        color-scheme = "prefer-dark";
        accent-color = "orange";
	font-antialiasing = "rgba";
	font-hinting = "slight";
	font-name = "Ubuntu Sans 12";
	monospace-font-name = "Ubuntu Sans Mono 12";
	icon-theme = "Yaru";
	clock-format = "12h";
	cursor-theme = "Yaru";
      };

    };
  }];
  
  environment.gnome.excludePackages = (with pkgs; [
    yelp
    epiphany
    atomix # puzzle game
    cheese # webcam tool
    epiphany # web browser
    evince # document viewer
    geary # email reader
    gedit # text editor
    simple-scan
    gnome-console
    gnome-text-editor
    gnome-maps
    gnome-clocks
    gnome-characters
    gnome-music
    gnome-photos
    gnome-tour
    gnome-contacts
    gnome-weather
    gnome-calendar
    gnome-connections
    snapshot
    hitori
    iagno
    tali
    totem
  ]);
}
