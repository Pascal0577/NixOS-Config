{ inputs, username, lib, ... }:

{
    imports = [
        inputs.noctalia.nixosModules.default
    ];

    services = {
        noctalia-shell.enable = true;
        upower.enable = true;
    };

    home-manager.users.${username} = {
        imports = [
            inputs.noctalia.homeModules.default
        ];

        home.file.".cache/noctalia/wallpapers.json" = {
            text = builtins.toJSON {
                defaultWallpaper = "/home/${username}/NixOS-Config/wallpapers/nord-arctic-fox.png";
                wallpapers = {
                    "DP-1" = "/home/${username}/NixOS-Config/wallpapers/nord-arctic-fox.png";
                    "eDP-1" = "/home/${username}/NixOS-Config/wallpapers/nord-arctic-fox.png";
                };
            };
        };

        programs.noctalia-shell = {
            enable = true;

            settings = {
                settingsVersion = 16;
                setupCompleted = true;
                bar = {
                    position = "top";
                    backgroundOpacity = 1.0;
                    monitors = [ ];
                    density = "default";
                    showCapsule = true;
                    floating = false;
                    marginVertical = 0.25;
                    marginHorizontal = 0.25;
                    outerCorners = false;

                    widgets = {
                        left = [
                            {
                                id = "SystemMonitor";
                                compactMode = false;
                                usePrimaryColor = true;
                                showMemoryUsage = true;
                                showCpuTemp = true;
                                showCpuUsage = true;
                                showGpuUsage = true;
                                showDiskUsage = true;
                                diskPath = "/";
                            }
                            {
                                displayMode = "alwaysShow";
                                id = "Battery";
                                showNoctaliaPerformance = true;
                                showPowerProfiles = true;
                                warningThreshold = 30;
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
                                characterCount = 2;
                                colorizeIcons = true;
                                followFocusedScreen = false;
                                hideUnoccupied = true;
                                showApplications = true;
                                showLabelsOnlyWhenOccupied = false;
                            }
                        ];
                        right = [
                            {
                                id = "Tray";
                                drawerEnabled = false;
                                colorizeIcons = false;
                            }
                            {
                                id = "plugin:privacy-indicator";
                            }
                            {
                                id = "NotificationHistory";
                                hideWhenZero = true;
                                showUnreadBadge = true;
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
                                id = "ControlCenter";
                                colorizeDistroLogo = true;
                                colorizeSystemIcon = "primary";
                                customIconPath = "";
                                enableColorization = true;
                                icon = "";
                                useDistroLogo = true;
                            }
                        ];
                    };
                };
                general = {
                    avatarImage = "~/Pictures/Profile_Pictures/moody.png";
                    dimmerOpacity = 0;
                    showScreenCorners = true;
                    forceBlackScreenCorners = true;
                    scaleRatio = 1;
                    radiusRatio = 0.5;
                    screenRadiusRatio = 0.5;
                    animationSpeed = 2;
                    animationDisabled = false;
                    compactLockScreen = false;
                    shadowDirection = "below";
                };
                location = {
                    name = "";
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
                    overviewEnabled = false;
                    directory = "/home/${username}/NixOS-Config/wallpapers/";
                    monitorDirectories = [ ];
                    enableMultiMonitorDirectories = false;
                    recursiveSearch = false;
                    setWallpaperOnAllMonitors = true;
                    fillMode = "crop";
                    fillColor = "#000000";
                    randomEnabled = false;
                    wallpaperChangeMode = "random";
                    randomIntervalSec = 300;
                    transitionDuration = 1500;
                    transitionType = "random";
                    transitionEdgeSmoothness = 0.05;
                    panelPosition = "follow_bar";
                    hideWallpaperFilenames = false;
                    useWallhaven = false;
                    wallhavenQuery = "";
                    wallhavenSorting = "relevance";
                    wallhavenOrder = "desc";
                    wallhavenCategories = "111";
                    wallhavenPurity = "100";
                    wallhavenRatios = "";
                    wallhavenApiKey = "";
                    wallhavenResolutionMode = "atleast";
                    wallhavenResolutionWidth = "";
                    wallhavenResolutionHeight = "";
                };
                appLauncher = {
                    customLaunchPrefixEnabled = false;
                    customLaunchPrefix = "";
                    enableClipPreview = true;
                    enableClipboardHistory = false;
                    position = "center";
                    backgroundOpacity = 1.0;
                    pinnedExecs = [ ];
                    useApp2Unit = false;
                    sortByMostUsed = true;
                    terminalCommand = "xterm -e";
                    viewMode = "list";
                };
                controlCenter = {
                    position = "top_right";
                    shortcuts = {
                        left = [
                            {
                                id = "ScreenRecorder";
                            }
                            {
                                id = "KeepAwake";
                            }
                            {
                                id = "NightLight";
                            }
                        ];
                        right = [
                        ];
                    };
                    cards = [
                        {
                            enabled = true;
                            id = "profile-card";
                        }
                        {
                            enabled = false;
                            id = "shortcuts-card";
                        }
                        {
                            enabled = false;
                            id = "audio-card";
                        }
                        {
                            enabled = false;
                            id = "weather-card";
                        }
                        {
                            enabled = true;
                            id = "media-sysmon-card";
                        }
                    ];
                };
                dock = {
                    enabled = false;
                    displayMode = "auto_hide";
                    backgroundOpacity = 1.0;
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
                    visualizerQuality = "low";
                    mprisBlacklist = [ ];
                    preferredPlayer = "";
                };
                ui = {
                    fontDefault = "Ubuntu Sans";
                    fontFixed = lib.mkForce "Ubuntu Mono";
                    fontDefaultScale = 1.1;
                    fontFixedScale = 1.1;
                    idleInhibitorEnabled = true;
                    tooltipsEnabled = true;
                    panelBackgroundOpacity = 1.0;
                };
                brightness = {
                    brightnessStep = 5;
                };
                colorSchemes = {
                    useWallpaperColors = false;
                    predefinedScheme = "Nord";
                    darkMode = true;
                    matugenSchemeType = "scheme-fruit-salad";
                    generateTemplatesForPredefined = false;
                };
                templates = {
                    gtk = true;
                    qt = true;
                    kcolorscheme = true;
                    kitty = false;
                    ghostty = false;
                    foot = false;
                    fuzzel = false;
                    discord = false;
                    discord_vesktop = false;
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
}
