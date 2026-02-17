{ inputs, pkgs, username, lib, config, ... }:
let
    hostSystem = pkgs.stdenv.hostPlatform.system;
in
{
    options.mySystem.applications.launcher.vicinae.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable my vicinae module";
    };

    config = lib.mkMerge [
        {
            nix.settings = {
                extra-substituters = [ "https://vicinae.cachix.org" ];
                extra-trusted-public-keys = [ 
                    "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
                ];
            };
        }

        (lib.mkIf config.mySystem.applications.launcher.vicinae.enable {
            mySystem.applications.launcher = {
                package = inputs.vicinae.packages.${hostSystem}.default;
                command = "vicinae vicinae://toggle";
            };

            home-manager.users.${username} = {
                imports = [
                    inputs.vicinae.homeManagerModules.default
                ];

                services.vicinae = {
                    enable = true;
                    package = inputs.vicinae.packages.${hostSystem}.default;
                    systemd = {
                        enable = true;
                        autoStart = true;
                        environment = { USE_LAYER_SHELL = 1; };
                    };
                    settings = {
                        favicon_service = "twenty";
                        pop_to_root_on_close = true;
                        search_files_in_root = true;

                        font = {
                            normal = {
                                size = 12;
                                normal = "Ubuntu Sans";
                            };
                        };

                        theme = {
                            light = {
                                name = "stylix";
                                icon_theme = "Papirus-Light";
                            };
                            dark = {
                                name = "stylix";
                                icon_theme = "Papirus-Dark";
                            };
                        };

                        launcher_window = {
                            csd = true;
                            opacity = 1.0;
                        };

                        extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
                        ];

                        favorites = [
                            "applications:zen-beta"
                            "applications:vesktop"
                            "clipboard:history"
                        ];

                        providers = {
                            clipboard.preferences.encryption = true;
                            core.entrypoints = {
                                about.enabled = false;
                                documentation.enabled = false;
                                keybind-settings.enabled = false;
                                manage-fallback.enabled = false;
                                oauth-token-store.enabled = false;
                                open-config-file.enabled = false;
                                open-default-config.enabled = false;
                                report-bug.enabled = false;
                                sponsor.enabled = false;
                            };
                            power.entrypoints = {
                                lock.enabled = false;
                                logout.enabled = false;
                                sleep.enabled = false;
                                soft-reboot.enabled = false;
                                suspend.enabled = false;
                            };
                            developer.enabled = false;
                            font.enabled = false;
                            system.enabled = false;
                            theme.enabled = false;
                            wm.enabled = false;
                        };
                    };
                };
            };
        })
    ];
}
