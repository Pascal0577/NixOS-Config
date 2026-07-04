{ inputs, username, config, lib, ... }:

{
    options.mySystem.applications.noctalia.enable =
        lib.mkEnableOption "Noctalia Shell module"
        // { default = (config.mySystem.desktop.choice == "niri"); };

    config = lib.mkIf config.mySystem.applications.noctalia.enable {
        mySystem.applications.launcher.command = lib.mkDefault "noctalia-shell ipc call launcher toggle";
        mySystem.applications.tuned.enable = lib.mkDefault true;

        nix.settings = {
            extra-substituters = [ "https://noctalia.cachix.org" ];
            extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
        };

        # to set icon theme
        environment.sessionVariables.QT_QPA_PLATFORMTHEME = "gtk3";

        home-manager.users.${username} = {
            imports = [ inputs.noctalia.homeModules.default ];

            stylix.targets.noctalia.enable = true;

            programs.noctalia = {
                enable = true;
                systemd.enable = true;
            };
        };
    };
}
