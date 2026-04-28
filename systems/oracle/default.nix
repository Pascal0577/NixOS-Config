{ username, lib, pkgs, ... }:

{
    mySystem = {
        ZFS.enable = true;
        impermanence.enable = false;
        server.enable = true;
        applications.neovim.enable = false;
    };

    home-manager.users.${username}.programs.helix = {
        extraPackages = lib.mkForce (with pkgs; [
            bash-language-server
            nixd
        ]);
    }; 
}
