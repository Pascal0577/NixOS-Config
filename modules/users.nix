{ self, inputs, pkgs, username, ... }:

{
    users.users.${username} = {
        hashedPasswordFile = "/nix/persist/passwd/${username}";
        isNormalUser = true;
        description = "Pascal";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
            home-manager
            nh
            self.packages.${pkgs.stdenv.hostPlatform.system}.renameat2
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
