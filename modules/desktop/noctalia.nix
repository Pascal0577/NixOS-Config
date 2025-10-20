{ pkgs, inputs, username, config, lib, ... }:
let
    directory = "/home/${username}/Pictures/Wallpapers";
    wallpaper = directory + "/" + "TranscodedWallpaper.png";
in
{
    options.mySystem.desktop.niri.noctalia.enable = lib.mkEnableOption "Noctalia shell for Niri";

    imports = [
        inputs.noctalia.nixosModules.default
    ];

    config = lib.mkIf config.mySystem.desktop.niri.noctalia.enable {
        environment.systemPackages = with pkgs; [
            inputs.noctalia.packages.${system}.default
        ];

        services.noctalia-shell.enable = true;

        home-manager.users.${username} = {
            imports = [
                inputs.noctalia.homeModules.default
            ];

            home.packages = with pkgs; [
                quickshell
            ];

            programs.noctalia-shell = {
                enable = true;

                colors = {
                    mError = "#ed8796";
                    mOnError = "#181926";
                    mOnPrimary = "#181926";
                    mOnSecondary = "#181926";
                    mOnSurfaceVariant = "#828282";
                    mOnSurface = "#a5adcb";
                    mOnTertiary = "#181926";
                    mOutline = "#3c3c3c";
                    mPrimary = "#eed49f";
                    mSecondary = "#3a5198";
                    mShadow = "#000000";
                    mSurface = "#1e2030";
                    mSurfaceVariant = "#24273a";
                    mTertiary = "#5c5e99";
                };

                settings = {
                    settingsVersion = 16;
                    setupCompleted = true;
                    bar = {
                        position = "top";
                        backgroundOpacity = 1;
                        monitors = [ ];
                        density = "default";
                        showCapsule = true;
                        floating = false;
                        marginVertical = 0.25;
                        marginHorizontal = 0.25;

                        widgets = {
                            left = [
                                {
                                    id = "SystemMonitor";
                                }
                                {
                                    id = "ActiveWindow";
                                    widgetWidth=290;
                                }
                            ];
                            center = [
                                {
                                    id = "Workspace";
                                    labelMode = "none";
                                }
                            ];
                            right = [
                                {
                                    id = "Tray";
                                }
                                {
                                    id = "NotificationHistory";
                                }
                                {
                                    id = "Bluetooth";
                                }
                                {
                                    id = "WiFi";
                                }
                                {
                                    id = "Volume";
                                }
                                {
                                    id = "Brightness";
                                }
                                {
                                    id = "Clock";
                                    formatHorizontal = "h:mm AP MMM d";
                                }
                                {
                                    id = "SidePanelToggle";
                                    useDistroLogo = true;
                                }
                            ];
                        };
                    };
                    general = {
                        avatarImage = "~/Pictures/Profile_Pictures/moody.png";
                        dimDesktop = false;
                        showScreenCorners = true;
                        forceBlackScreenCorners = false;
                        scaleRatio = 1;
                        radiusRatio = 0.5;
                        screenRadiusRatio = 1;
                        animationSpeed = 2;
                        animationDisabled = false;
                        compactLockScreen = false;
                    };
                    location = {
                        name = "Kentucky";
                        weatherEnabled = false;
                        useFahrenheit = true;
                        use12hourFormat = true;
                        showWeekNumberInCalendar = false;
                    };
                    screenRecorder = {
                        directory = "";
                        frameRate = 60;
                        audioCodec = "opus";
                        videoCodec = "av1";
                        quality = "very_high";
                        colorRange = "limited";
                        showCursor = true;
                        audioSource = "default_output";
                        videoSource = "portal";
                    };
                    wallpaper = {
                        enabled = true;
                        directory = directory;
                        monitors = [
                            {
                                name="eDP-1";
                                wallpaper=wallpaper;
                            }
                        ];
                    };
                    appLauncher = {
                        enableClipboardHistory = false;
                        position = "center";
                        backgroundOpacity = 1;
                        pinnedExecs = [ ];
                        useApp2Unit = false;
                        sortByMostUsed = true;
                        terminalCommand = "xterm -e";
                    };
                    controlCenter = {
                        position = "close_to_bar_button";
                        shortcuts = {
                            left = [
                                {
                                    id = "WiFi";
                                }
                                {
                                    id = "Bluetooth";
                                }
                                {
                                    id = "ScreenRecorder";
                                }
                                {
                                    id = "WallpaperSelector";
                                }
                            ];
                            right = [
                                {
                                    id = "Notifications";
                                }
                                {
                                    id = "PowerProfile";
                                }
                                {
                                    id = "KeepAwake";
                                }
                                {
                                    id = "NightLight";
                                }
                            ];
                        };
                        cards = [
                            {
                                enabled = true;
                                id = "profile-card";
                            }
                            {
                                enabled = true;
                                id = "shortcuts-card";
                            }
                            {
                                enabled = true;
                                id = "audio-card";
                            }
                            {
                                enabled = true;
                                id = "weather-card";
                            }
                            {
                                enabled = true;
                                id = "media-sysmon-card";
                            }
                        ];
                    };
                    dock = {
                        displayMode = "auto_hide";
                        backgroundOpacity = 1;
                        floatingRatio = 1;
                        onlySameOutput = true;
                        monitors = [ ];
                        pinnedApps = [ ];
                        colorizeIcons = false;
                    };
                    network = {
                        wifiEnabled = true;
                    };
                    notifications = {
                        doNotDisturb = false;
                        monitors = [ ];
                        location = "top_right";
                        alwaysOnTop = false;
                        lastSeenTs = 0;
                        respectExpireTimeout = false;
                        lowUrgencyDuration = 3;
                        normalUrgencyDuration = 8;
                        criticalUrgencyDuration = 15;
                    };
                    osd = {
                        enabled = true;
                        location = "top_right";
                        monitors = [ ];
                        autoHideMs = 2000;
                        alwaysOnTop = false;
                    };
                    audio = {
                        volumeStep = 5;
                        volumeOverdrive = false;
                        cavaFrameRate = 60;
                        visualizerType = "linear";
                        mprisBlacklist = [ ];
                        preferredPlayer = "";
                    };
                    ui = {
                        fontDefault = "Ubuntu Sans";
                        fontFixed = "Adwaita Mono";
                        fontDefaultScale = 1.1;
                        fontFixedScale = 1.1;
                        idleInhibitorEnabled = true;
                        tooltipsEnabled = true;
                    };
                    brightness = {
                        brightnessStep = 5;
                    };
                    colorSchemes = {
                        useWallpaperColors = true;
                        predefinedScheme = "Monochrome";
                        darkMode = true;
                        matugenSchemeType = "scheme-fruit-salad";
                        generateTemplatesForPredefined = true;
                    };
                    templates = {
                        gtk = true;
                        qt = true;
                        kcolorscheme = true;
                        kitty = false;
                        ghostty = false;
                        foot = false;
                        fuzzel = false;
                        discord = true;
                        discord_vesktop = true;
                        discord_webcord = false;
                        discord_armcord = false;
                        discord_equibop = false;
                        discord_lightcord = false;
                        discord_dorion = false;
                        pywalfox = true;
                        enableUserTemplates = true;
                    };
                    nightLight = {
                        enabled = false;
                        forced = false;
                        autoSchedule = true;
                        nightTemp = "4000";
                        dayTemp = "6500";
                        manualSunrise = "06:30";
                        manualSunset = "18:30";
                    };
                    hooks = {
                        enabled = false;
                        wallpaperChange = "";
                        darkModeChange = "";
                    };
                    battery = {
                        chargingMode = 0;
                    };
                };
            };
        };
    };
}
