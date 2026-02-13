{ inputs, pkgs, username, ... }:

{
    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        trusted-users = [ "${username}" ];
    };

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
                stateVersion = "25.11";
            };
        };
    };
}
