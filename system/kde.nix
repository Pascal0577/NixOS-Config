{ pkgs, ... }:

{
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs; [
    kdePackages.elisa
    kdePackages.kdepim-runtime
    kdePackages.kmahjongg 
    kdePackages.kmines 
    kdePackages.konversation 
    kdePackages.kpat 
    kdePackages.ksudoku 
    kdePackages.ktorrent 
  ];
}
