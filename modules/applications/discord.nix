{ username, lib, config, ... }:

{
    options.mySystem.applications.discord.enable =
        lib.mkEnableOption "Discord/Vesktop module"
        // { default = !config.mySystem.server.enable; };

    config = lib.mkIf config.mySystem.applications.discord.enable {
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

                vencord = {
                    themes.stylix = lib.mkAfter ''
                        ::selection {
                            background-color: #${config.lib.stylix.colors.base02-hex};
                            color: #${config.lib.stylix.colors.base05-hex};
                        }
                    '';

                    settings = {
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
        };
    };
}
