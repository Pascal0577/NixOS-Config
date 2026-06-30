{ username, pkgs, lib, config, ... }:

let
    anime4k-shaders = pkgs.fetchzip {
        url = "https://github.com/bloc97/Anime4K/releases/download/v4.0.1/Anime4K_v4.0.zip";
        sha256 = "sha256-9B6U+KEVlhUIIOrDauIN3aVUjZ/gQHjFArS4uf/BpaM=";
        stripRoot = false;
    };

    videoMimes = [
        "application/mpeg4-iod"
        "application/mpeg4-muxcodetable"
        "application/mxf"
        "application/ram"
        "application/sdp"
        "application/streamingmedia"
        "application/vnd.apple.mpegurl"
        "application/vnd.ms-asf"
        "application/vnd.rn-realmedia"
        "application/vnd.rn-realmedia-vbr"
        "application/x-extension-mp4"
        "application/x-flash-video"
        "application/x-matroska"
        "application/x-streamingmedia"
        "video/3gp"
        "video/3gpp"
        "video/3gpp2"
        "video/divx"
        "video/dv"
        "video/fli"
        "video/flv"
        "video/mp2t"
        "video/mp4"
        "video/mp4v-es"
        "video/mpeg"
        "video/mpeg-system"
        "video/msvideo"
        "video/ogg"
        "video/quicktime"
        "video/vnd.mpegurl"
        "video/vnd.rn-realvideo"
        "video/webm"
        "video/x-avi"
        "video/x-flc"
        "video/x-fli"
        "video/x-flv"
        "video/x-m4v"
        "video/x-matroska"
        "video/x-mpeg"
        "video/x-mpeg-system"
        "video/x-mpeg2"
        "video/x-ms-asf"
        "video/x-ms-wm"
        "video/x-ms-wmv"
        "video/x-ms-wmx"
        "video/x-msvideo"
        "video/x-nsv"
        "video/x-ogm+ogg"
        "video/x-theora"
        "video/x-theora+ogg"
        "x-content/video-dvd"
        "x-scheme-handler/mms"
        "x-scheme-handler/mmsh"
        "x-scheme-handler/rtmp"
        "x-scheme-handler/rtp"
        "x-scheme-handler/rtsp"
    ];

    videoBindings = lib.genAttrs videoMimes (_: "mpv.desktop");
in
{
    options.mySystem.applications.mpv.enable =
        lib.mkEnableOption "mpv media player"
        // { default = config.mySystem.applications.gtk-apps.enable; };

    config = lib.mkIf config.mySystem.applications.mpv.enable {
        xdg.mime.defaultApplications = {} // videoBindings;

        home-manager.users.${username} = {
            programs.mpv = {
                enable = true;

                scripts = with pkgs.mpvScripts; [
                    uosc
                    thumbfast
                    mpris
                ];

                config = {
                    profile = "fast";

                    save-position-on-quit = "no";
                    force-seekable = "yes";
                    cursor-autohide = "500";

                    osd-bar = "no";
                    border = "no";

                    vo = "gpu-next";
                    gpu-api = "vulkan";
                    hwdec = "auto";
                    hwdec-codecs = "all";

                    scale = "ewa_lanczos4sharpest";
                    scale-antiring = "1";
                    dscale = "mitchell";
                    cscale = "ewa_lanczossharp";
                    correct-downscaling = "yes";
                    linear-downscaling = "yes";
                    scaler-resizes-only = "yes";
                    deband = "yes";
                    deband-iterations = "2";
                    deband-threshold = "64";
                    deband-range = "32";
                    deband-grain = "16";

                    volume = "100";

                    target-prim = "bt.709";
                    target-trc = "srgb";
                    target-gamut = "bt.709";
                    target-contrast = "auto";
                    tone-mapping = "bt.2390";

                    alang = "en";
                    slang = "en";
                    vlang = "en";

                    aid = "auto";
                    sid = "no";
                    vid = "auto";

                    input-default-bindings = "no";
                    input-builtin-bindings = "no";

                    fs = "yes";
                };

                bindings = {
                    "tab" = "script-binding uosc/toggle-ui";
                    "alt+-" = "add video-zoom -0.25";
                    "alt+=" = "add video-zoom 0.25";
                    "space" = "cycle pause; script-binding uosc/flash-pause-indicator";
                    "right" = "seek 6; script-binding uosc/flash-timeline";
                    "left" = "seek -6; script-binding uosc/flash-timeline";
                    "shift+right" = "seek 60; script-binding uosc/flash-timeline";
                    "shift+left" = "seek -60; script-binding uosc/flash-timeline";
                    "c" = "cycle sub-visibility";
                    "up" = "add volume 2";
                    "down" = "add volume -2";

                    "CTRL+1" =
                      "no-osd change-list glsl-shaders set \"~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl:~~/shaders/Anime4K_Restore_CNN_S.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl\"";
                    "CTRL+2" =
                      "no-osd change-list glsl-shaders set \"~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl\"";
                    "CTRL+3" =
                      "no-osd change-list glsl-shaders set \"~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl\"";
                    "CTRL+0" = "no-osd change-list glsl-shaders clr \"\"";
                };
            };

            xdg.configFile."mpv/shaders".source = "${anime4k-shaders}";
        };
    };
}
