{ inputs, pkgs, username, ... }:

{
    users.users.${username} = {
        isNormalUser = true;
        description = "Pascal";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
            home-manager
            nh
        ];
    };

    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs username; };
        users.${username} = {
            programs.home-manager.enable = true;
            home = {
                username = username;
                homeDirectory = "/home/${username}";
                stateVersion = "26.05";
            };
        };
    };
}
