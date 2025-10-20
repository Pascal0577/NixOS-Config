{ inputs, pkgs, username, ... }:

{
    nix.settings = {
        substituters = [ "https://vicinae.cachix.org" ];
        trusted-public-keys = [ "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=" ];
    };

    home-manager.users.${username} = {
        imports = [
            inputs.vicinae.homeManagerModules.default
        ];

#       services.vicinae = {
#           enable = true;
#           autoStart = true;
#           package = inputs.vicinae.packages.${pkgs.system}.default;
#           settings = {
#               faviconService = "twenty"; # twenty | google | none
#               popToRootOnClose = true;
#               rootSearch.searchFiles = false;
#               font = {
#                   normal = "Ubuntu Sands";
#                   size = 13;
#               };
#               theme = {
#                   name = "catppuccin-macchiato";
#                   iconTheme = "Yaru-dark";
#               };
#               window = {
#                   csd = true;
#                   opacity = 0.95;
#                   rounding = 10;
#               };
#           };
#       };
    };
}
