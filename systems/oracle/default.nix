{ username, ... }:

{
    mySystem = {
        ZFS.enable = true;
        impermanence.enable = false;
        server.enable = true;
	    applications.helix.enable = true;
	    theme.everforest.enable = true;
    };

    stylix.enable = true;
    stylix.autoEnable = false;    
    home-manager.users.${username}.stylix.targets.helix.enable = true;
}
