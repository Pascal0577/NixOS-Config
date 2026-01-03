{ username, inputs, pkgs, ... }:
{
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

        programs.niri.settings.binds."Mod+Space".action.spawn = [ "nc" "-U" "/run/user/1000/walker/walker.sock" ];

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

                        @keyframes slideInUp {
                          from {
                            opacity: 0;
                            transform: translateY(20px);
                          }
                          to {
                            opacity: 1;
                            transform: translateY(0);
                          }
                        }

                        @keyframes slideInDown {
                          from {
                            opacity: 0;
                            transform: translateY(-10px);
                          }
                          to {
                            opacity: 1;
                            transform: translateY(0);
                          }
                        }

                        @keyframes scaleIn {
                          from {
                            opacity: 0;
                            transform: scale(0.95);
                          }
                          to {
                            opacity: 1;
                            transform: scale(1);
                          }
                        }

                        @keyframes pulse {
                          0%, 100% {
                            opacity: 1;
                          }
                          50% {
                            opacity: 0.6;
                          }
                        }

                        @keyframes glow {
                          0%, 100% {
                            box-shadow: 0 0 20px alpha(@accent_bg_color, 0.2);
                          }
                          50% {
                            box-shadow: 0 0 30px alpha(@accent_bg_color, 0.4);
                          }
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
                          animation: scaleIn 200ms ease-out;
                        }

                        .preview-box,
                        .elephant-hint,
                        .placeholder {
                          color: @theme_fg_color;
                          animation: slideInUp 300ms ease-out;
                        }

                        .box {
                          min-height: 400px;
                        }

                        .search-container {
                          border-radius: 14px;
                          animation: slideInDown 250ms ease-out;
                        }

                        .input placeholder {
                          opacity: 0.5;
                          transition: opacity 200ms ease;
                        }

                        .input:focus placeholder,
                        .input:active placeholder {
                          opacity: 0.3;
                        }

                        .input {
                          caret-color: @nord_frost;
                          background: rgba(59, 66, 82, 0.8);
                          padding: 10px 14px;
                          color: @theme_fg_color;
                          border-radius: 14px;
                          border: 2px solid transparent;
                          transition: all 250ms cubic-bezier(0.4, 0, 0.2, 1);
                          transform: scale(1);
                        }

                        .input:focus,
                        .input:active {
                          border-color: alpha(@accent_bg_color, 0.6);
                          background: rgba(67, 76, 94, 0.85);
                          box-shadow: 0 0 20px alpha(@accent_bg_color, 0.2);
                          transform: scale(1.01);
                        }

                        .content-container {
                          margin-top: 8px;
                          min-height: 400px;
                        }

                        .placeholder {
                          padding: 20px;
                          min-height: 280px;
                        }

                        .scroll {
                          min-height: 280px;
                        }

                        .list {
                          color: @theme_fg_color;
                          min-height: 280px;
                          overflow: visible;
                          padding: 6px;
                        }

                        child {
                          animation: slideInUp 200ms ease-out;
                          animation-fill-mode: backwards;
                        }

                        child:nth-child(1) { animation: none; }
                        child:nth-child(2) { animation-delay: 30ms; }
                        child:nth-child(3) { animation-delay: 60ms; }
                        child:nth-child(4) { animation-delay: 90ms; }
                        child:nth-child(5) { animation-delay: 120ms; }
                        child:nth-child(6) { animation-delay: 150ms; }
                        child:nth-child(7) { animation-delay: 180ms; }
                        child:nth-child(8) { animation-delay: 210ms; }
                        child:nth-child(9) { animation-delay: 240ms; }
                        child:nth-child(10) { animation-delay: 270ms; }

                        .item-box {
                          border-radius: 12px;
                          padding: 6px 10px;
                          transition: all 200ms cubic-bezier(0.4, 0, 0.2, 1);
                          border: 1px solid transparent;
                          transform: scale(1);
                        }

                        .item-quick-activation {
                          background: alpha(@nord_frost, 0.25);
                          border-radius: 6px;
                          padding: 4px 6px;
                          margin-right: 8px;
                          border: 1px solid alpha(@nord_frost, 0.4);
                          transition: all 150ms ease;
                          transform: scale(1);
                        }

                        child:hover .item-quick-activation {
                          transform: scale(1.05);
                          background: alpha(@nord_frost, 0.35);
                        }

                        child:hover .item-box {
                          background: alpha(@accent_bg_color, 0.25);
                          transform: translateX(4px) scale(1.01);
                        }

                        child:selected .item-box {
                          background: alpha(@accent_bg_color, 0.4);
                          border: 1px solid alpha(@accent_bg_color, 0.5);
                          box-shadow: 0 4px 12px alpha(@accent_bg_color, 0.3);
                          transform: scale(1.015);
                        }

                        .item-text-box {
                          transition: transform 200ms ease;
                        }

                        child:hover .item-text-box {
                          transform: translateX(2px);
                        }

                        .item-subtext {
                          font-size: 11px;
                          opacity: 0.7;
                          color: #d8dee9;
                          margin-top: 2px;
                          transition: opacity 200ms ease;
                        }

                        child:hover .item-subtext {
                          opacity: 0.85;
                        }

                        .providerlist .item-subtext {
                          font-size: unset;
                          opacity: 0.75;
                        }

                        .item-image-text {
                          font-size: 24px;
                          transition: transform 200ms ease;
                        }

                        child:hover .item-image-text {
                          transform: scale(1.1);
                        }

                        .preview {
                          border: 1px solid alpha(@accent_bg_color, 0.4);
                          padding: 10px;
                          border-radius: 12px;
                          color: @theme_fg_color;
                          background: rgba(59, 66, 82, 0.6);
                          margin-top: 8px;
                          animation: slideInUp 300ms ease-out;
                          transition: all 200ms ease;
                        }

                        .calc .item-text {
                          font-size: 20px;
                          color: @nord_frost;
                          transition: all 200ms ease;
                        }

                        child:hover .calc .item-text {
                          transform: scale(1.05);
                          text-shadow: 0 0 8px alpha(@nord_frost, 0.4);
                        }

                        .calc .item-subtext {
                        }

                        .symbols .item-image {
                          font-size: 20px;
                          transition: transform 200ms cubic-bezier(0.68, -0.55, 0.265, 1.55);
                        }

                        child:hover .symbols .item-image {
                          transform: rotate(5deg) scale(1.1);
                        }

                        .todo.done .item-text-box {
                          opacity: 0.25;
                          transition: opacity 300ms ease;
                        }

                        .todo.urgent {
                          font-size: 20px;
                          color: #d08770;
                          animation: pulse 2s ease-in-out infinite;
                        }

                        .todo.active {
                          font-weight: bold;
                          color: @nord_frost;
                        }

                        child:hover .todo.active .item-text-box {
                          animation: pulse 1s ease-in-out;
                        }

                        .bluetooth.disconnected {
                          opacity: 0.5;
                          transition: opacity 300ms ease;
                        }

                        .preview .large-icons {
                          -gtk-icon-size: 48px;
                          transition: transform 200ms ease;
                        }

                        .preview:hover .large-icons {
                          transform: scale(1.05);
                        }

                        .keybinds-wrapper {
                          border-top: 1px solid rgba(59, 66, 82, 0.6);
                          font-size: 11px;
                          opacity: 0.7;
                          color: @theme_fg_color;
                          margin-top: 8px;
                          padding-top: 8px;
                          animation: slideInUp 400ms ease-out;
                        }

                        .keybinds {
                        }

                        .keybind {
                          margin: 2px 0;
                          transition: transform 150ms ease;
                        }

                        .keybind:hover {
                          transform: translateX(4px);
                        }

                        .keybind-bind {
                          color: @nord_frost;
                          font-weight: bold;
                          text-transform: lowercase;
                          background: alpha(@nord_frost, 0.2);
                          padding: 2px 6px;
                          border-radius: 4px;
                          margin-right: 6px;
                          transition: all 150ms ease;
                        }

                        .keybind:hover .keybind-bind {
                          background: alpha(@nord_frost, 0.3);
                          transform: scale(1.05);
                        }

                        .keybind-label {
                          transition: opacity 150ms ease;
                        }

                        .keybind:hover .keybind-label {
                          opacity: 1;
                        }

                        .error {
                          padding: 10px 12px;
                          background: alpha(@error_bg_color, 0.9);
                          color: @error_fg_color;
                          border-radius: 10px;
                          border: 1px solid alpha(@error_bg_color, 0.6);
                          margin: 4px;
                          animation: slideInDown 250ms ease-out, pulse 2s ease-in-out infinite;
                        }

                        :not(.calc).current {
                          font-style: italic;
                          color: @nord_aurora;
                          transition: all 200ms ease;
                        }

                        child:hover :not(.calc).current {
                          text-shadow: 0 0 8px alpha(@nord_aurora, 0.4);
                        }
                    '';
                };
            };
        };
    };
}
