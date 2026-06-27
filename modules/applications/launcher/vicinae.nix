{ username, lib, config, ... }:

{
    config = lib.mkIf (config.mySystem.applications.launcher.choice == "vicinae") {
        mySystem.applications.launcher.command = "vicinae vicinae://toggle";

        home-manager.users.${username} = {
            stylix.targets.vicinae.enable = true;

            programs.vicinae = {
                enable = true;
                systemd = {
                    enable = true;
                    autoStart = true;
                };
                settings = {
                    favicon_service = "twenty";
                    pop_to_root_on_close = true;
                    search_files_in_root = true;
                    launcher_window.csd = true;

                    font.normal = {
                        size = 12;
                        normal = "Ubuntu Sans";
                    };


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
    };
}
