{ hostname, username, inputs, pkgs, ... }:

{
    imports = [
        ./appimage.nix
        ./boot.nix
        ./gaming.nix
        ./latex.nix
        ./locale-time.nix
        ./power-management.nix
        ./shell.nix
        ./services.nix
        ./virtualization.nix
        ./zig.nix
        ./themes/everforest.nix
        ./applications/discord.nix
        ./applications/fastfetch.nix
        ./applications/ghostty.nix
        ./applications/git.nix
        ./applications/mathematica.nix
        ./applications/nautilus.nix
        ./applications/neovim.nix
        ./applications/obs-studio.nix
        ./applications/swayidle.nix
        ./applications/zen-browser.nix
    ];

    environment = {
        systemPackages = with pkgs; [
            playerctl
            losslesscut-bin
            pinta
            deluge
            onlyoffice-desktopeditors
        ];

        sessionVariables = {
            NIXOS_OZONE_WL = "1";
        };
    };

    hardware = {
        bluetooth.enable = true;
        graphics.enable = true;
    };

    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        trusted-users = [ "${username}" ];
    };

    networking = {
        hostName = hostname;
        networkmanager.enable = true;
        modemmanager.enable = false;
        firewall = {
            enable = true;
            trustedInterfaces = [ "virbr0" ];
            allowedTCPPorts = [ 25565 ]; # Minecraft
        };
    };

    security.rtkit.enable = true;

    users.users.${username} = {
        isNormalUser = true;
        description = "Pascal";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
            home-manager
            nh
        ];
    };

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.extraSpecialArgs = { inherit inputs username; };
    home-manager.users.${username} = {
        home.username = username;
        home.homeDirectory = "/home/${username}";
        home.stateVersion = "25.11";
        programs.home-manager.enable = true;
    };

    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "26.05";
}
