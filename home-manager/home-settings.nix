{ pkgs, username, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
    packages = with pkgs; [
      playerctl
      losslesscut-bin
      pinta
      qbittorrent
      icoextract
    ];

    file = {

    };

    sessionVariables = {
    };
  };

  programs = {
    home-manager.enable = true;
    mangohud.enable = true;
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

}
