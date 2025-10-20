{ pkgs, inputs, username, config, lib, ... }:

{
    config = lib.mkIf config.mySystem.desktop.kde.enable {
        services = {
            desktopManager.plasma6.enable = true;
            displayManager.sddm.enable = true;
            displayManager.sddm.wayland.enable = true;
        };

        environment.plasma6.excludePackages = with pkgs.kdePackages; [
            elisa
            kdepim-runtime 
            kmahjongg 
            kmines 
            konversation 
            kpat 
            ksudoku 
            ktorrent 
        ];

        home-manager.users.${username} = {
            imports = [
                inputs.plasma-manager.homeModules.plasma-manager
            ];

            home.packages = with pkgs; [
                papirus-icon-theme
                kdePackages.karousel
            ];

            programs.plasma = {
                enable = true;
                overrideConfig = false;

                desktop = {
                    icons = {
                        alignment = "left";
                        arrangement = "topToBottom";
                        folderPreviewPopups = true;
                        lockInPlace = true;
                        previewPlugins = [
                          "audiothumbnail"
                          "fontthumbnail"
                        ];
                        size = 4;
                        sorting = {
                          descending = true;
                          foldersFirst = true;
                          mode = "name";
                        };
                    };

                    mouseActions = {
                        leftClick = null;
                        middleClick = "applicationLauncher";
                        rightClick = "contextMenu";
                        verticalScroll = "switchVirtualDesktop";
                    };

                    widgets = [
                        
                    ];
                };

                # fonts = {
                #     fixedWidth = {
                #         family = "Ubuntu Sans";
                #         capitalization = "mixedCase";
                #         fixedPitch = false;
                #         letterSpacing = 0;
                #         letterSpacingType = "percentage";
                #         pixelSize = null;
                #         pointSize = 12;
                #         stretch = "anyStretch";
                #         strikeOut = false;
                #         style = "normal";
                #         styleHint = "anyStyle";
                #         styleStrategy = {
                #             antialiasing = "prefer";
                #             matchingPrefer = "default";
                #             noFontMerging = false;
                #             prefer = "default"; # What type of font (e.g. bitmap, outline, etc.)
                #             preferNoShaping = false; # Enabling can increase performance for some fonts
                #         };
                #         underline = false;
                #         weight = "normal"; # Also try thin
                #         wordSpacing = 0;
                #     };

                #     general = {
                #         family = "Ubuntu Sans";
                #         capitalization = "mixedCase";
                #         fixedPitch = false;
                #         letterSpacing = 0;
                #         letterSpacingType = "percentage";
                #         pixelSize = null;
                #         pointSize = 12;
                #         stretch = "anyStretch";
                #         strikeOut = false;
                #         style = "normal";
                #         styleHint = "anyStyle";
                #         styleStrategy = {
                #             antialiasing = "prefer";
                #             matchingPrefer = "default";
                #             noFontMerging = false;
                #             prefer = "default"; # What type of font (e.g. bitmap, outline, etc.)
                #             preferNoShaping = false; # Enabling can increase performance for some fonts
                #         };
                #         underline = false;
                #         weight = "normal"; # Also try thin
                #         wordSpacing = 0;
                #     };
                # 
                #     menu = {
                #         family = "Ubuntu Sans";
                #         capitalization = "mixedCase";
                #         fixedPitch = false;
                #         letterSpacing = 0;
                #         letterSpacingType = "percentage";
                #         pixelSize = null;
                #         pointSize = 11;
                #         stretch = "anyStretch";
                #         strikeOut = false;
                #         style = "normal";
                #         styleHint = "anyStyle";
                #         styleStrategy = {
                #             antialiasing = "prefer";
                #             matchingPrefer = "default";
                #             noFontMerging = false;
                #             prefer = "default"; # What type of font (e.g. bitmap, outline, etc.)
                #             preferNoShaping = false; # Enabling can increase performance for some fonts
                #         };
                #         underline = false;
                #         weight = "normal"; # Also try thin
                #         wordSpacing = 0;
                #     };
                # 
                #     small = {
                #         family = "Ubuntu Sans";
                #         capitalization = "mixedCase";
                #         fixedPitch = false;
                #         letterSpacing = 0;
                #         letterSpacingType = "percentage";
                #         pixelSize = null;
                #         pointSize = 8;
                #         stretch = "anyStretch";
                #         strikeOut = false;
                #         style = "normal";
                #         styleHint = "anyStyle";
                #         styleStrategy = {
                #             antialiasing = "prefer";
                #             matchingPrefer = "default";
                #             noFontMerging = false;
                #             prefer = "default"; # What type of font (e.g. bitmap, outline, etc.)
                #             preferNoShaping = false; # Enabling can increase performance for some fonts
                #         };
                #         underline = false;
                #         weight = "normal"; # Also try thin
                #         wordSpacing = 0;
                #     };
                # 
                #     toolbar = {
                #         family = "Ubuntu Sans";
                #         capitalization = "mixedCase";
                #         fixedPitch = false;
                #         letterSpacing = 0;
                #         letterSpacingType = "percentage";
                #         pixelSize = null;
                #         pointSize = 8;
                #         stretch = "anyStretch";
                #         strikeOut = false;
                #         style = "normal";
                #         styleHint = "anyStyle";
                #         styleStrategy = {
                #             antialiasing = "prefer";
                #             matchingPrefer = "default";
                #             noFontMerging = false;
                #             prefer = "default"; # What type of font (e.g. bitmap, outline, etc.)
                #             preferNoShaping = false; # Enabling can increase performance for some fonts
                #         };
                #         underline = false;
                #         weight = "normal"; # Also try thin
                #         wordSpacing = 0;
                #     };
                # 
                #     windowTitle = {
                #         family = "Ubuntu Sans";
                #         capitalization = "mixedCase";
                #         fixedPitch = false;
                #         letterSpacing = 0;
                #         letterSpacingType = "percentage";
                #         pixelSize = null;
                #         pointSize = 11;
                #         stretch = "anyStretch";
                #         strikeOut = false;
                #         style = "normal";
                #         styleHint = "anyStyle";
                #         styleStrategy = {
                #             antialiasing = "prefer";
                #             matchingPrefer = "default";
                #             noFontMerging = false;
                #             prefer = "default"; # What type of font (e.g. bitmap, outline, etc.)
                #             preferNoShaping = false; # Enabling can increase performance for some fonts
                #         };
                #         weight = "normal"; # Also try thin
                #         wordSpacing = 0;
                #         underline = false;
                #     };
                #     # End of fonts hell
                # };

                hotkeys.commands."Launch-Konsole" = {
                    command = "konsole";
                    comment = "launches the terminal";
                    key = "Meta+Return";
                    # keys = [
                    #   ""
                    # ];
                    name = "Launch Konsole"; # Same as defined above
                };

                input = {
                    mice = [
                        {
                            acceleration = 0.5;
                            accelerationProfile = "default";
                            enable = true;
                            leftHanded = false;
                            middleButtonEmulation = false;
                            # This can be found by looking at the Name attribute in the section in the /proc/bus/input/devices path belonging to the mouse
                            name = "Logitech M720 Triathlon";
                            naturalScroll = false;
                            # This can be found by looking at the Product attribute in the section in the /proc/bus/input/devices path belonging to the mouse
                            productId = "405e";
                            scrollSpeed = 1;
                            # This can be found by looking at the Vendor attribute in the section in the /proc/bus/input/devices path belonging to the mouse
                            vendorId = "046d";
                        } 
                    ];

                    touchpads = [
                        {
                            accelerationProfile = "default";
                            disableWhileTyping = true;
                            enable = true;
                            leftHanded = false;
                            middleButtonEmulation = false;
                            name = "PIXA3848:00 093A:3848 Touchpad";
                            naturalScroll = true;
                            pointerSpeed = 0;
                            productId = "3848";
                            tapToClick = true;
                            rightClickMethod = "twoFingers";
                            scrollMethod = "twoFingers";
                            scrollSpeed = 0.3;
                            tapAndDrag = true;
                            tapDragLock = true;
                            twoFingerTap = "rightClick";
                            vendorId = "093a";
                        }
                    ];
                };
                
                krunner = {
                    activateWhenTypingOnDesktop = true;
                    historyBehavior = "enableAutoComplete";
                    position = "center";
                    shortcuts = {
                        launch = "Meta+Space";
                        runCommandOnClipboard = "Meta+Shift";
                    };
                };

                kscreenlocker = {
                    appearance = {
                        alwaysShowClock = true;
                        showMediaControls = true;
                        # wallpaper = "path/to/the/wallpaper.png";
                    };
                        autoLock = true;
                        lockOnResume = false;
                        lockOnStartup = false;
                        passwordRequired = true;
                        passwordRequiredDelay = 5;
                        timeout = 10; # In minutes
                };

                kwin = {
                    borderlessMaximizedWindows = true;
                    cornerBarrier = null;
                    edgeBarrier = null;
                    effects = {
                        blur = {
                            enable = true;
                            noiseStrength = 8; # Between 0-14, inclusive
                            strength = 4; # Between 1-15, inclusive
                        };
                        cube.enable = false;
                        dimAdminMode.enable = true;
                        dimInactive.enable = true;
                        fallApart.enable = false;
                        fps.enable = false;
                        shakeCursor.enable = true;
                        slideBack.enable = true;
                        snapHelper.enable = true;
                        translucency.enable = false;
                        windowOpenClose.animation = "fade";
                        wobblyWindows.enable = false;

                        desktopSwitching = {
                            animation = "slide";
                            navigationWrapping = false;
                        };
                        
                        minimization = {
                            animation = "magiclamp";
                            duration = 800; # In milliseconds. Only available with magic lamp
                        };
                    };
                    
                    nightLight = {
                        enable = false;
                        location.latitude = null;
                        location.longitude = null;
                        mode = "times";
                        temperature.day = 4500;
                        temperature.night = 3500;
                        time.evening = "20:00";
                        time.morning = "07:00";
                        transitionTime = 30;
                    };

                    scripts = {
                        polonium = {
                            enable = false;
                            settings = {
                                enableDebug = false;
                                borderVisibility = "borderAll";
                                callbackDelay = 100; # Between 1-200, inclusive
                                maximizeSingleWindow = true;
                                resizeAmount = 100; # Between 1-450, inclusive
                                saveOnTileEdit = true;
                                tilePopups = false;

                                filter = {
                                    processes = [
                                      # "firefox"
                                    ];
                                    windowTitles = [
                                      # "Discord"
                                    ];
                                };

                                layout = {
                                    engine = "binaryTree"; # binaryTree, half, threeColumn, monocle, kwin
                                    insertionPoint = "right"; # left, right, activeWindow
                                    rotate = true;
                                };
                            };
                        };
                    };

                    tiling = {
                        padding = 0; # Between 0-36, inclusive
                        layout = {
                            id = "cf5c25c2-4217-4193-add6-b5971cb543f2";
                            tiles = {
                                layoutDirection = "horizontal";
                                tiles = [
                                    {
                                        width = 0.5;
                                    }
                                    {
                                        layoutDirection = "vertical";
                                        tiles = [
                                            {
                                                height = 0.5;
                                            }
                                            {
                                                height = 0.5;
                                            }
                                        ];
                                        width = 0.5;
                                    }
                                ];
                            };
                        };
                    };

                    titlebarButtons = {
                        left = [
                            "on-all-desktops"
                            "keep-above-windows"
                        ];
                        right = [
                            "minimize"
                            "maximize"
                            "close"
                        ];
                    };

                    virtualDesktops = {
                        names = [
                            "Desktop 1"
                            "Desktop 2"
                            "Desktop 3"
                            "Desktop 4"
                            "Desktop 5"
                        ];
                        number = 5;
                        rows = 5;
                    };
                    # End of kwin hell
                };

                panels = [
                    {
                        alignment = "left";
                        extraSettings = null; # See https://develop.kde.org/docs/plasma/scripting/
                        floating = false;
                        height = 44;
                        hiding = "none";
                        lengthMode = "fill";
                        location = "top";
                        maxLength = null;
                        minLength = null;
                        offset = null;
                        opacity = "translucent";
                        widgets = [
                            {
                                # See modules/widgets for supported widgets and options for these widgets
                                kickoff = {
                                    sortAlphabetically = true;
                                    icon = "nix-snowflake-white";
                                    favoritesDisplayMode = "grid";
                                    applicationsDisplayMode = "grid";
                                };              
                            }
                            "org.kde.plasma.pager"
                            {
                                iconTasks = {
                                    launchers = [
                                        "applications:org.kde.dolphin.desktop"
                                        "applications:org.kde.konsole.desktop"
                                    ];
                                    iconsOnly = true;
                                    appearance = {
                                        showTooltips = true;
                                        highlightWindows = false;
                                        indicateAudioStreams = true;
                                        fill = false;
                                        rows = {
                                            multirowView = "lowSpace";
                                        };
                                    };

                                    behavior = {
                                        grouping = {
                                            method = "byProgramName";
                                            clickAction = "cycle";
                                        };
                                        sortingMethod = "manually";
                                        minimizeActiveTaskOnClick = true;
                                        middleClickAction = "newInstance";

                                        wheel = {
                                            switchBetweenTasks = true;
                                            ignoreMinimizedTasks = true;
                                        };

                                        showTasks = {
                                            onlyInCurrentDesktop = true;
                                            onlyMinimized = false;
                                        };

                                        unhideOnAttentionNeeded = true;
                                        newTasksAppearOn = "right";
                                    };
                                };
                            }
                            {
                                panelSpacer = {
                                    expanding = true;
                                };
                            }
                            "org.kde.plasma.marginsseparator"
                            "org.kde.plasma.systemtray"
                            "org.kde.plasma.digitalclock"
                            "org.kde.plasma.showdesktop"
                        ];
                    }
                ];

                powerdevil = {
                    AC = {
                        autoSuspend.action = "nothing";
                        dimDisplay.enable = true;
                        dimDisplay.idleTimeout = 300;
                        displayBrightness = null;
                        inhibitLidActionWhenExternalMonitorConnected = true;
                        powerButtonAction = "sleep";
                        powerProfile = "performance";
                        turnOffDisplay.idleTimeout = 600;
                        turnOffDisplay.idleTimeoutWhenLocked = 120;
                        whenLaptopLidClosed = "lockScreen";
                        whenSleepingEnter = "standby";
                    };

                    battery = {
                        autoSuspend.action = "sleep";
                        autoSuspend.idleTimeout = 600; # Duration in seconds
                        dimDisplay.enable = true;
                        dimDisplay.idleTimeout = 180;
                        displayBrightness = null;
                        inhibitLidActionWhenExternalMonitorConnected = true;
                        powerButtonAction = "sleep";
                        powerProfile = "balanced";
                        turnOffDisplay.idleTimeout = 300;
                        turnOffDisplay.idleTimeoutWhenLocked = 60;
                        whenLaptopLidClosed = "lockScreen";
                        whenSleepingEnter = "standby";
                    };

                    lowBattery = {
                        autoSuspend.action = "sleep";
                        autoSuspend.idleTimeout = 600; # Duration in seconds
                        dimDisplay.enable = true;
                        dimDisplay.idleTimeout = 180;
                        displayBrightness = null;
                        inhibitLidActionWhenExternalMonitorConnected = true;
                        powerButtonAction = "sleep";
                        powerProfile = "powerSaving";
                        turnOffDisplay.idleTimeout = 300;
                        turnOffDisplay.idleTimeoutWhenLocked = 60;
                        whenLaptopLidClosed = "lockScreen";
                        whenSleepingEnter = "standby";
                    };

                    batteryLevels.criticalAction = "nothing";
                    batteryLevels.lowLevel = 20;
                    general.pausePlayersOnSuspend = true;
                };

                session = {
                    general.askForConfirmationOnLogout = true;
                    sessionRestore.excludeApplications = [ ];
                    sessionRestore.restoreOpenApplicationsOnLogin = "whenSessionWasManuallySaved";
                };

                shortcuts = { 
                    kwin = {
                        "Switch Window Left" = "Meta+A";
                        "Switch Window Right" = "Meta+D";
                    };
                };

                spectacle.shortcuts = {
                    launchWithoutCapturing = "Meta+Shift+S";
                    captureActiveWindow = "Meta+Print";
                    captureEntireDesktop = "Shift+Print";
                    captureRectangularRegion = "Print";

                    recordScreen = "Meta+Shift+R";
                    recordWindow = "Meta+Alt+R";
                };

                window-rules = [
                  # {
                  #   "Firefox".apply = {
                  #     apply = "initially"; # do-not-affect, force, initially, remember
                  #     value = "who fucking knows";
                  #     description = "desc";
                  #     match = {
                  #       machine = {
                  #         type = "substring"; # exact, regex, substring
                  #         value = "firefox";
                  #       };
                  #       title = {
                  #         type = "substring"; # exact, regex, or substring
                  #         value = "firefox";
                  #       };
                  #       window-class = {
                  #         match-whole = false;
                  #         type = "substring"; # exact, regex, or substring
                  #         value = "Firefox";
                  #       };
                  #       window-role = {
                  #         type = "substring"; # exact, regex, or substring
                  #         value = "firefox";
                  #       };
                  #       window-types = [ ]; # desktop, dialog, dock, menubar, normal, osd, spash, toolbar, torn-of-menu, utility
                  #     };
                  #   };
                  # }
                ];

                windows.allowWindowsToRememberPositions = true;

                workspace = {
                    enableMiddleClickPaste = true;
                    clickItemTo = "open";
                    colorScheme = "BreezeDark"; # plasma-apply-colorscheme --list-schemes for valid options
                    cursor = {
                        size = 24;
                        theme = "Breeze_Snow";
                    };

                    iconTheme = "Papirus";
                    # lookAndFeel = "org.kde.breezedark.desktop"; # plasma-apply-lookandfeel --list for valid options
                    soundTheme = "freedesktop";
                    splashScreen.engine = null;
                    splashScreen.theme = null;
                    theme = "breeze-dark";
                    tooltipDelay = 500; # In milliseconds
                    wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Kay/contents/images/1080x1920.png";
                    wallpaperBackground = {
                        blur = false;
                        color = null;
                    };
                    wallpaperFillMode = "stretch";

                    windowDecorations = {
                        library = "org.kde.kwin.aurorae"; # To view all available values, see the library key in the org.kde.kdecoration2 section of $HOME/.config/kwinrc after imperatively applying the window decoration via the System Settings app.
                        theme = "__aurorae__svg__CatppuccinMocha-Modern";
                    };
                };
            };
        };
    };
}
