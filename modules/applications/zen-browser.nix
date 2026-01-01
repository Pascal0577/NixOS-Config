{ inputs, config, username, lib, pkgs, ... }:

{
    home-manager.users.${username} = {
        imports = [
            inputs.zen-browser.homeModules.beta
        ];

        programs.zen-browser = {
            enable = true;
            policies = let
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
                    "gfx.webrender.all" = true;
                    "network.http.http3.enabled" = true;
                    "privacy.resistFingerprinting" = true;
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

            profiles."pascal" = {
                settings = {
                    "zen.glance.enabled" = false;
                    "zen.welcome-screen.seen" = true;
                    "zen.urlbar.behavior" = "float";
                    "zen.theme.use-sysyem-colors" = true;
                };

                containersForce = true;
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

                pinsForce = true;
                pins = {
                    "NixOS Packages" = {
                        id = "48e8a119-5a14-4826-9545-91c8e8dd3bf6";
                        url = "https://search.nixos.org/packages?channel=unstable&";
                        position = 1000;
                        isEssential = true;
                    };
                    "Youtube" = {
                        id = "1eabb6a3-911b-4fa9-9eaf-232a3703db19";
                        url = "https://www.youtube.com/";
                        position = 2000;
                        isEssential = true;
                    };
                    "Home Manager Options" = {
                        id = "5065293b-1c04-40ee-ba1d-99a231873864";
                        url = "https://home-manager-options.extranix.com/?query=&release=master";
                        position = 3000;
                        isEssential = true;
                    };
                };

                spacesForce = true;
                spaces = let
                    containers = config.home-manager.users.${username}.programs.zen-browser.profiles."pascal".containers;
                in {
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
}
