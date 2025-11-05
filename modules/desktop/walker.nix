{ lib, config, username, inputs, pkgs, ... }:

{
    config = lib.mkIf config.mySystem.desktop.niri.walker.enable {

        nix.settings = {
            extra-substituters = [
                "https://walker.cachix.org"
                "https://walker-git.cachix.org"
            ];
            extra-trusted-public-keys = [
                "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
                "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
            ];
        };

        environment.systemPackages = with pkgs; [
            gst_all_1.gstreamer
            gst_all_1.gst-libav
            gst_all_1.gst-plugins-base
            gst_all_1.gst-plugins-good
            gst_all_1.gst-plugins-bad
            gst_all_1.gst-plugins-ugly
            gst_all_1.gst-vaapi
        ];

        home-manager.users.${username} = {
            imports = [ 
                inputs.walker.homeManagerModules.default
            ];

            # Needed so walker can find gstreamer stuff and not crash
            # when trying to preview a video
            home.file.".config/systemd/user/walker.service.d/env.conf".text = ''
                [Service]
                Environment=GST_PLUGIN_PATH=/run/current-system/sw/lib/gstreamer-1.0
            '';

            programs.elephant = {
                providers = [
                    "desktopapplications"
                    "runner"
                    "unicode"
                    "symbols"
                    "files"
                    "clipboard"
                    "calc"
                    "providerlist"
                ];
            };

            programs.walker = {
                enable = true;
                runAsService = true;
                config = {
                    theme = "nord";
                    force_keyboard_focus = true;
                    placeholders.default = {
                        input = "Search";
                        list = "No Results";
                    };
                    providers.prefixes = [
                        { provider = "providerlist"; prefix = "/"; }
                        { provider = "unicode"; prefix = ","; }
                        { provider = "files"; prefix = "."; }
                    ];
                    keybinds.quick_activate = ["F1" "F2" "F3"];
                };

                themes = {
                    "nord" = {
                        style = ''
                            @define-color window_bg_color rgba(46, 52, 64, 0.95);
                            @define-color accent_bg_color #5e81ac;
                            @define-color theme_fg_color #eceff4;
                            @define-color error_bg_color #bf616a;
                            @define-color error_fg_color #eceff4;
                            @define-color nord_frost #88c0d0;
                            @define-color nord_aurora #b48ead;

                            * {
                              all: unset;
                            }

                            .normal-icons {
                              -gtk-icon-size: 16px;
                            }

                            .large-icons {
                              -gtk-icon-size: 32px;
                            }

                            scrollbar {
                              opacity: 0;
                            }

                            .box-wrapper {
                              box-shadow:
                                0 19px 38px rgba(0, 0, 0, 0.5),
                                0 15px 12px rgba(0, 0, 0, 0.4);
                              background: @window_bg_color;
                              padding: 8px;
                              border-radius: 20px;
                              border: 1px solid alpha(@accent_bg_color, 0.4);
                              min-width: 600px;
                              min-height: 400px;
                            }

                            .preview-box,
                            .elephant-hint,
                            .placeholder {
                              color: @theme_fg_color;
                            }

                            .box {
                              min-height: 400px;
                              max-height: 400px;
                              display: flex;
                              flex-direction: column;
                            }

                            .search-container {
                              border-radius: 14px;
                              flex-shrink: 0;
                            }

                            .input placeholder {
                              opacity: 0.5;
                            }

                            .input {
                              caret-color: @nord_frost;
                              background: rgba(59, 66, 82, 0.8);
                              padding: 10px 14px;
                              color: @theme_fg_color;
                              border-radius: 14px;
                              border: 2px solid transparent;
                              transition: all 200ms ease;
                            }

                            .input:focus,
                            .input:active {
                              border-color: alpha(@accent_bg_color, 0.6);
                              background: rgba(67, 76, 94, 0.85);
                              box-shadow: 0 0 20px alpha(@accent_bg_color, 0.2);
                            }

                            .content-container {
                              margin-top: 8px;
                              min-height: 400px;
                              max-height: 400px;
                              flex: 1;
                              display: flex;
                              flex-direction: column;
                            }

                            .placeholder {
                              padding: 20px;
                              min-height: 280px;
                              display: flex;
                              align-items: center;
                              justify-content: center;
                            }

                            .scroll {
                              min-height: 280px;
                              max-height: 280px;
                              overflow-y: auto;
                              scrollbar-width: none;
                            }

                            .list {
                              color: @theme_fg_color;
                              min-height: 280px;
                              max-height: 280px;
                            }

                            child {
                            }

                            .item-box {
                              border-radius: 12px;
                              padding: 6px 10px;
                              transition: all 150ms ease;
                              border: 1px solid transparent;
                            }

                            .item-quick-activation {
                              background: alpha(@nord_frost, 0.25);
                              border-radius: 6px;
                              padding: 4px 6px;
                              margin-right: 8px;
                              border: 1px solid alpha(@nord_frost, 0.4);
                              backdrop-filter: blur(8px);
                              -webkit-backdrop-filter: blur(8px);
                            }

                            child:hover .item-box {
                              background: alpha(@accent_bg_color, 0.25);
                              backdrop-filter: blur(8px);
                              -webkit-backdrop-filter: blur(8px);
                            }

                            child:selected .item-box {
                              background: alpha(@accent_bg_color, 0.4);
                              border: 1px solid alpha(@accent_bg_color, 0.5);
                              box-shadow: 0 4px 12px alpha(@accent_bg_color, 0.3);
                              backdrop-filter: blur(10px);
                              -webkit-backdrop-filter: blur(10px);
                            }

                            .item-text-box {
                            }

                            .item-subtext {
                              font-size: 11px;
                              opacity: 0.7;
                              color: #d8dee9;
                              margin-top: 2px;
                            }

                            .providerlist .item-subtext {
                              font-size: unset;
                              opacity: 0.75;
                            }

                            .item-image-text {
                              font-size: 24px;
                            }

                            .preview {
                              border: 1px solid alpha(@accent_bg_color, 0.4);
                              padding: 10px;
                              border-radius: 12px;
                              color: @theme_fg_color;
                              background: rgba(59, 66, 82, 0.6);
                              backdrop-filter: blur(12px);
                              -webkit-backdrop-filter: blur(12px);
                              margin-top: 8px;
                            }

                            .calc .item-text {
                              font-size: 20px;
                              color: @nord_frost;
                            }

                            .calc .item-subtext {
                            }

                            .symbols .item-image {
                              font-size: 20px;
                            }

                            .todo.done .item-text-box {
                              opacity: 0.25;
                            }

                            .todo.urgent {
                              font-size: 20px;
                              color: #d08770;
                            }

                            .todo.active {
                              font-weight: bold;
                              color: @nord_frost;
                            }

                            .bluetooth.disconnected {
                              opacity: 0.5;
                            }

                            .preview .large-icons {
                              -gtk-icon-size: 48px;
                            }

                            .keybinds-wrapper {
                              border-top: 1px solid rgba(59, 66, 82, 0.6);
                              font-size: 11px;
                              opacity: 0.7;
                              color: @theme_fg_color;
                              margin-top: 8px;
                              padding-top: 8px;
                            }

                            .keybinds {
                            }

                            .keybind {
                              margin: 2px 0;
                            }

                            .keybind-bind {
                              color: @nord_frost;
                              font-weight: bold;
                              text-transform: lowercase;
                              background: alpha(@nord_frost, 0.2);
                              padding: 2px 6px;
                              border-radius: 4px;
                              backdrop-filter: blur(6px);
                              -webkit-backdrop-filter: blur(6px);
                              margin-right: 6px;
                            }

                            .keybind-label {
                            }

                            .error {
                              padding: 10px 12px;
                              background: alpha(@error_bg_color, 0.9);
                              color: @error_fg_color;
                              border-radius: 10px;
                              border: 1px solid alpha(@error_bg_color, 0.6);
                              backdrop-filter: blur(10px);
                              -webkit-backdrop-filter: blur(10px);
                              margin: 4px;
                            }

                            :not(.calc).current {
                              font-style: italic;
                              color: @nord_aurora;
                            }
                        '';
                    };
                };
            };
        };
    };
}
