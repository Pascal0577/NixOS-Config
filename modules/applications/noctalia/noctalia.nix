{ inputs, username, config, lib, ... }:

{
    options.mySystem.applications.noctalia.enable =
        lib.mkEnableOption "Noctalia Shell module"
        // { default = (config.mySystem.desktop.choice == "niri"); };

    imports = [ inputs.noctalia-greeter.nixosModules.default ];

    config = lib.mkIf config.mySystem.applications.noctalia.enable {
        mySystem.applications.launcher.command = lib.mkDefault "noctalia msg panel-open launcher";
        mySystem.applications.tuned.enable = lib.mkDefault true;

        nix.settings = {
            extra-substituters = [ "https://noctalia.cachix.org" ];
            extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
        };

        # to set icon theme
        environment.sessionVariables.QT_QPA_PLATFORMTHEME = "gtk3";

        environment.persistence."/nix/persist".directories =
            lib.mkIf config.mySystem.impermanence.enable [ "/var/lib/noctalia-greeter" ];

        programs.noctalia-greeter = {
            enable = true;
            greeter-args = "";
            settings = {
                keyboard.layout = "us";
                cursor = {
                    theme = "${config.stylix.cursor.name}";
                    size = config.stylix.cursor.size;
                    package = config.stylix.cursor.package;
                };
                appearance = {
                    scheme = "Synced";
                    hide_logo = true;
                };
            };
        };

        home-manager.users.${username} = {
            imports = [ inputs.noctalia.homeModules.default ];

            stylix.targets.noctalia.enable = true;
            programs.noctalia = {
                enable = true;
                systemd.enable = true;
            };

            home.file.".local/state/noctalia/settings.toml".source = ./settings.toml;
        };
    };
}
