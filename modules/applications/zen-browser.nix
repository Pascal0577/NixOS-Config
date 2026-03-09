{ inputs, config, username, lib, pkgs, ... }:

{
    options.mySystem.applications.zen-browser.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable my Zen Browser module";
    };

    config = lib.mkIf config.mySystem.applications.zen-browser.enable {
        home-manager.users.${username} = {
            imports = [ inputs.zen-browser.homeModules.beta ];

            programs.zen-browser = {
                enable = true;
                policies =
                let
                    mkLockedAttrs = builtins.mapAttrs (_: value: {
                        Value = value;
                        Status = "locked";
                    });

                    mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
                        installation_mode = "force_installed";
                    });
                in {
                    ExtensionSettings = mkExtensionSettings {
                        "uBlock0@raymondhill.net" = "ublock-origin";
                        "jid1-MnnxcxisBPnSXQ@jetpack" = "privacy-badger17";
                        "firefox@tampermonkey.net" = "tampermonkey";
                        "{73a6fe31-595d-460b-a920-fcc0f8843232}" = "noscript";
                    };

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
                        "browser.urlbar.suggest.sports" = false;
                        "browser.urlbar.suggest.trending" = false;
                        "browser.urlbar.suggest.weather" = false;
                        "browser.urlbar.suggest.engines" = false;

                        "gfx.webrender.all" = true;
                        "network.http.http3.enabled" = true;

                        "privacy.resistFingerprinting" = true;
                        "privacy.resistFingerprinting.randomization.canvas.use_siphash" = true;
                        "privacy.resistFingerprinting.randomization.daily_reset.enabled" = true;
                        "privacy.resistFingerprinting.randomization.daily_reset.private.enabled" = true;
                        "privacy.resistFingerprinting.block_mozAddonManager" = true;
                        "privacy.clearOnShutdown.cookies" = true;

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

                        "zen.workspaces.separate-essentials" = false;
                        "zen.pinned-tab-manager.restore-pinned-tabs-to-pinned-url" = true;
                        "zen.workspaces.continue-where-left-off" = true;
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

                    spaces = {
                        "General" = {
                            id = "2fb789ed-1362-4b70-b2f9-aece628a156d";
                            position = 1000;
                            container = containers.General.id;
                        };
                        "Pascal" = {
                            id = "5eb97172-5a03-4402-9f86-7ce270851c86";
                            icon = "❄️";
                            position = 2000;
                            container = containers.Pascal.id;
                            theme = {
                                type = "gradient";
                                colors = [
                                    {
                                        red = 185;
                                        green = 200;
                                        blue = 215;
                                        algorithm = "floating";
                                    }
                                ];
                            };
                        };
                        "School" = {
                            id = "129a2fbb-3247-48c9-84dc-19283d2a75d7";
                            icon = "🎓";
                            position = 4000;
                            container = containers.School.id;
                            theme = {
                                type = "gradient";
                                colors = [
                                    {
                                        red = 150;
                                        green = 190;
                                        blue = 230;
                                        algorithm = "floating";
                                    }
                                ];
                            };
                        };
                        "Personal" = {
                            id = "bf6500c6-b86d-4430-a23b-7fa11c2f0f9d";
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
                                        algorithm = "floating";
                                    }
                                ];
                            };
                        };
                    };

                    pins = {
                        "GitHub" = {
                            id = "d1308ffd-cc13-45bf-89d0-658cef0f00b3";
                            workspace = spaces.General.id;
                            container = containers.General.id;
                            url = "https://github.com";
                            isEssential = true;
                            position = 101;
                        };
                        "Youtube" = {
                            id = "7daece55-7a2a-4d8c-bdc7-feb43da50e57";
                            workspace = spaces.General.id;
                            container = containers.General.id;
                            url = "https://youtube.com";
                            isEssential = true;
                            position = 102;
                        };
                        "Blackboard" = {
                            id = "1289ea9b-2285-4bab-8f19-0750700747ec";
                            workspace = spaces.School.id;
                            container = containers.School.id;
                            url = "https://wku.blackboard.com/";
                            isEssential = true;
                            position = 401;
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
                        "zen.theme.use-system-colors" = true;
                        "zen.tabs.show-newtab-vertical" = false;
                    };

                    mods = [ "7d577b21-4685-4db2-bb17-d39d08eec199" ];

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
