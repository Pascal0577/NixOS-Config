{ inputs, config, username, lib, ... }:

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
                    "zen.theme.accent-color" = "#d56199";
                    "zen.welcome-screen.seen" = true;
                    "zen.urlbar.behavior" = "float";
                    "zen.theme.use-sysyem-colors" = true;
                };

                containersForce = true;
                containers = {
                    Personal = {
                        color = "purple";
                        icon = "fingerprint";
                        id = 1;
                    };
                    Work = {
                        color = "blue";
                        icon = "briefcase";
                        id = 2;
                    };
                    Shopping = {
                        color = "yellow";
                        icon = "dollar";
                        id = 3;
                    };
                };
                spacesForce = true;
                spaces = let
                    containers = config.home-manager.users.${username}.programs.zen-browser.profiles."pascal".containers;
                in {
                    "Personal" = {
                        id = "c6de089c-410d-4206-961d-ab11f988d40a";
                        position = 1000;
                    };
                    "Pascal" = {
                        id = "cdd10fab-4fc5-494b-9041-325e5759195b";
                        icon = "❗";
                        container = containers."Work".id;
                        position = 2000;
                    };
                    "School" = {
                        id = "78aabdad-8aae-4fe0-8ff0-2a0c6c4ccc24";
                        icon = "🎓";
                        container = containers."Shopping".id;
                        position = 3000;
                    };
                };
            };
        };

        xdg.desktopEntries.zen-beta = lib.mkIf config.mySystem.nvidia.enable {
            actions = {
                "New-Private-Window" = {
                    exec = "nvidia-offload zen-beta --private-window %U";
                    name = "New Private Window";
                };
                "Profile-Manager-Window" = {
                    exec = "nvidia-offload zen-beta --ProfileManager %U";
                    name = "Profile Manager";
                };
            };
            name = "Zen Browser (Beta)";
            exec = "nvidia-offload zen-beta --name zen-beta %U";
            icon = "zen-browser";
            prefersNonDefaultGPU = true;
            type = "Application";
            startupNotify = true;
            terminal = false;
            mimeType = [
                "text/html"
                "text/xml"
                "application/xhtml+xml"
                "application/vnd.mozilla.xul+xml"
                "x-scheme-handler/http"
                "x-scheme-handler/https"
            ];
        };
    };
}
