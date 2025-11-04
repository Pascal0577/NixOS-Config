{ pkgs, username, ... }:

{
    home-manager.users.${username} = {
        home.packages = with pkgs; [
            vesktop
        ];

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
                discordBranch = "canary";
                appBadge = true;
                arRPC = true;
                minimizeToTray = false;
                tray = false;
                customTitleBar = true;
                enableSplashScreen = false;
            };

            vencord.settings = {
                autoUpdate = false;
                useQuickCss = true;
                enabledThemes = ["nordic.theme.css"];
                plugins = {
                    FakeNitro.enabled = true;
                    FixYoutubeEmbeds.enabled = true;
                    YoutubeAdblock.enabled = true;
                    BetterUploadButton.enabled = true;
                    WebScreenShareFixes.enabled = true;
                    NoTrack = {
                        enabled = true;
                        disableAnalytics = true;
                    };
                };
            };
        };
    };
}
