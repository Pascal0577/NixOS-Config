{ username, pkgs, ... }:

{
    environment.systemPackages = [ pkgs.gajim ];
    home-manager.users.${username} = {
        home.file.".config/vesktop/settings/quickCss.css".text = ''
            body {
                font-family: 'Ubuntu Sans';
                font-weight: normal;
            }
        '';

        programs.vesktop = {
            enable = true;
            settings = {
                hardwareAcceleration = true;
                hardwareVideoAcceleration = true;
                discordBranch = "stable";
                appBadge = true;
                arRPC = true;
                minimizeToTray = false;
                tray = false;
                customTitleBar = true;
                enableSplashScreen = false;
            };

            vencord.settings = {
                autoUpdate = true;
                useQuickCss = true;
                plugins = {
                    FakeNitro.enabled = true;
                    FixYoutubeEmbeds.enabled = true;
                    YoutubeAdblock.enabled = true;
                    BetterUploadButton.enabled = true;
                    WebScreenShareFixes.enabled = true;
                    FixImagesQuality.enabled = true;
                    NoTrack = {
                        enabled = true;
                        disableAnalytics = true;
                    };
                };
            };
        };
    };
}
