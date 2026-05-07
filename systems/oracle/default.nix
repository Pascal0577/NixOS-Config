{ inputs, username, ... }:

{
    mySystem = {
        ZFS.enable = true;
        impermanence.enable = false;
        server.enable = true;
	    applications.helix.enable = true;
	    theme.everforest.enable = true;
    };

    imports = [ inputs.website.nixosModules.webserver ];
    pscl-webserver = {
        enable = true;
        interface = "enp0s6";
    };

    stylix.enable = true;
    stylix.autoEnable = false;    
    home-manager.users.${username}.stylix.targets.helix.enable = true;
}
