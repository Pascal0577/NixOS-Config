{ username, inputs, ... }:

{
    imports = [
        ./appimage.nix
        ./discord.nix
        ./fastfetch.nix
        ./ghostty.nix
        ./git.nix
        ./configuration.nix
        ./hardware-configuration.nix
        ./nvidia.nix
        ./obs-studio.nix
        ./secure-boot.nix
        ./shell.nix
        ./steam.nix
        ./zig.nix
        ./virtualization.nix
        ./desktop
        ./settings.nix
        # ./mathematica.nix
        ./neovim/ghostty-theme.nix
        ./neovim/neovim.nix
    ];

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.extraSpecialArgs = { inherit inputs username; };
    home-manager.users.${username} = {
        home.username = username;
        home.homeDirectory = "/home/${username}";
        home.stateVersion = "25.11";
        programs.home-manager.enable = true;
    };
}
