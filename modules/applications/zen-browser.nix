{ inputs, config, username, lib, pkgs, ... }:

{
    options.mySystem.applications.zen-browser.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable my Zen Browser module";
    };

    config = lib.mkIf config.mySystem.applications.zen-browser.enable {
        home-manager.users.${username} = {
            imports = [
                inputs.zen-browser.homeModules.beta
            ];

            programs.zen-browser = {
                enable = true;
                policies =
                let
                    mkLockedAttrs = builtins.mapAttrs (_: value: {
                        Value = value;
                        Status = "locked";
                    });

#                    mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
#                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
#                        installation_mode = "force_installed";
#                    });
                in {
#                    ExtensionSettings = mkExtensionSettings {
#
#                    };

                    Preferences = mkLockedAttrs {
                        "browser.tabs.warnOnClose" = false;
                        "browser.aboutConfig.showWarning" = false;
                        "browser.tabs.fadeOutUnloadedTabs" = true;
                        "browser.newtabpage.activity-stream.trendingSearch.defaultSearchEngine" = "DuckDuckGo";
                        "browser.urlbar.placeholderName.private" = "DuckDuckGo";
                        "browser.urlbar.suggest.history" = false;
                        "browser.urlbar.suggest.recentsearches" = false;
                        "browser.urlbar.suggest.openpage" = false;
                        "browser.urlbar.suggest.yelp" = false;
                        "browser.urlbar.suggest.addons" = false;
                        "gfx.webrender.all" = true;
                        "network.http.http3.enabled" = true;
                        "privacy.resistFingerprinting" = true;

                        "datareporting.policy.dataSubmissionEnabled" = false;
                        "datareporting.healthreport.uploadEnabled" = false;
                        "toolkit.telemetry.unified" = false;
                        "toolkit.telemetry.enabled" = false;
                        "toolkit.telemetry.server" = "data:,";
                        "toolkit.telemetry.archive.enabled" = false;
                        "toolkit.telemetry.newProfilePing.enabled" = false;
                        "toolkit.telemetry.shutdownPingSender.enabled" = false;
                        "toolkit.telemetry.updatePing.enabled" = false;
                        "toolkit.telemetry.bhrPing.enabled" = false;
                        "toolkit.telemetry.firstShutdownPing.enabled" = false;
                        "toolkit.telemetry.coverage.opt-out" = true;
                        "toolkit.coverage.opt-out" = true;
                        "toolkit.coverage.endpoint.base" = "";

                        "widget.use-xdg-desktop-portal.mime-handler" = 1;
                        "widget.use-xdg-desktop-portal.file-picker" = 1;
                    };

                    AutofillAddressEnabled = false;
                    AutofillCreditCardEnabled = false;
                    DisableAppUpdate = true;
                    DisableFeedbackCommands = true;
                    DisableFirefoxStudies = true;
                    DisablePocket = true;
                    DisableTelemetry = true;
                    DontCheckDefaultBrowser = true;
                    NoDefaultBookmarks = true;
                    OfferToSaveLogins = false;
                    EnableTrackingProtection = {
                        Value = true;
                        Locked = true;
                        Cryptomining = true;
                        Fingerprinting = true;
                        SuspectedFingerprinting = true;
                        EmailTracking = true;
                    };
                };

                profiles."pascal" = let
                    containers = {
                        General = {
                            color = "blue";
                            icon = "circle";
                            id = 1;
                        };
                        Pascal = {
                            color = "orange";
                            icon = "briefcase";
                            id = 2;
                        };
                        School = {
                            color = "yellow";
                            icon = "dollar";
                            id = 3;
                        };
                        Personal = {
                            color = "purple";
                            icon = "pet";
                            id = 4;
                        };
                    };

                    pins = {
                        "NixOS Packages" = {
                            id = "48e8a119-5a14-4826-9545-91c8e8dd3bf6";
                            url = "https://search.nixos.org/packages?channel=unstable&";
                            position = 101;
                            isEssential = true;
                        };
                        "Youtube" = {
                            id = "1eabb6a3-911b-4fa9-9eaf-232a3703db19";
                            url = "https://www.youtube.com/";
                            position = 102;
                            isEssential = true;
                        };
                        "Home Manager Options" = {
                            id = "5065293b-1c04-40ee-ba1d-99a231873864";
                            url = "https://home-manager-options.extranix.com/?query=&release=master";
                            position = 103;
                            isEssential = true;
                        };
                    };

                    spaces = {
                        "General" = {
                            id = "c6de089c-410d-4206-961d-ab11f988d40a";
                            container = containers."General".id;
                            position = 1000;
                            theme = {
                                type = "gradient";
                                colors = [
                                    {
                                        red = 46;
                                        green = 52;
                                        blue = 64;
                                        algorithm = "floating";
                                    }
                                ];
                            };
                        };
                        "Pascal" = {
                            id = "cdd10fab-4fc5-494b-9041-325e5759195b";
                            icon = "❗";
                            container = containers."Pascal".id;
                            position = 2000;
                            theme = {
                                type = "gradient";
                                colors = [
                                    {
                                        red = 46;
                                        green = 52;
                                        blue = 64;
                                        algorithm = "floating";
                                    }
                                ];
                            };
                        };
                        "School" = {
                            id = "78aabdad-8aae-4fe0-8ff0-2a0c6c4ccc24";
                            icon = "🎓";
                            container = containers."School".id;
                            position = 4000;
                            theme = {
                                type = "gradient";
                                colors = [
                                    {
                                        red = 97;
                                        green = 58;
                                        blue = 66;
                                        algorithm = "floating";
                                    }
                                ];
                            };
                        };
                        "Personal" = {
                            id = "42ccc4c6-c0a2-0ff8-0ef4-eaa8dadbaa87";
                            icon = "🐉";
                            container = containers."Personal".id;
                            position = 3000;
                            theme = {
                                type = "gradient";
                                colors = [
                                    {
                                        red = 21;
                                        green = 18;
                                        blue = 32;
                                        algorithm = "analogous";
                                    }
                                ];
                            };
                        };
                    };
                in {
                    containersForce = true;
                    pinsForce = true;
                    spacesForce = true;
                    inherit containers pins spaces;

                    settings = {
                        "zen.glance.enabled" = false;
                        "zen.welcome-screen.seen" = true;
                        "zen.urlbar.behavior" = "float";
                        "zen.theme.use-sysyem-colors" = true;
                    };

                    search = {
                        force = true;
                        default = "ddg";
                        engines = let
                            nixSnowflakeIcon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                        in {
                            "Nix Packages" = {
                                urls = [
                                    {
                                        template = "https://search.nixos.org/packages";
                                        params = [
                                            {
                                              name = "type";
                                              value = "packages";
                                            }
                                            {
                                              name = "channel";
                                              value = "unstable";
                                            }
                                            {
                                              name = "query";
                                              value = "{searchTerms}";
                                            }
                                        ];
                                    }
                                ];
                                icon = nixSnowflakeIcon;
                                definedAliases = ["np"];
                            };
                            "Nix Options" = {
                                urls = [
                                    {
                                        template = "https://search.nixos.org/options";
                                        params = [
                                            {
                                              name = "channel";
                                              value = "unstable";
                                            }
                                            {
                                              name = "query";
                                              value = "{searchTerms}";
                                            }
                                        ];
                                    }
                                ];
                                icon = nixSnowflakeIcon;
                                definedAliases = ["nop"];
                            };
                            "Home Manager Options" = {
                                urls = [
                                    {
                                        template = "https://home-manager-options.extranix.com/";
                                        params = [
                                            {
                                              name = "query";
                                              value = "{searchTerms}";
                                            }
                                            {
                                              name = "release";
                                              value = "master"; # unstable
                                            }
                                        ];
                                    }
                                ];
                                icon = nixSnowflakeIcon;
                                definedAliases = ["hmop"];
                            };
                            bing.metaData.hidden = "true";
                        };
                    };
                };
            };
        };
    };
}
