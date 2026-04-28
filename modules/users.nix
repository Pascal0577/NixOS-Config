{ inputs, pkgs, username, ... }:

{
    users.users.${username} = {
        isNormalUser = true;
        description = "Pascal";
        extraGroups = [ "networkmanager" "wheel" ];
        initialHashedPassword = "$y$j9T$wvltSKqqN8rILLpbDzNsP1$m3FGz45jGXG82xieFyEgIinzggARUW/1H85QLMEl4aA";
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
