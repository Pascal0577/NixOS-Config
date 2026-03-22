{ pkgs, lib, config, ... }:

{
    options.mySystem.applications.gtk-apps.enable = lib.mkEnableOption "gtk-apps";

    config = lib.mkIf config.mySystem.applications.gtk-apps.enable {
        environment.systemPackages = with pkgs; [
            baobab
            totem
            constrict
            curtail
            deluge
            pinta
            blanket
            resources
            video-trimmer
            loupe
        ];

        xdg.mime.defaultApplications = {
            "video/mkv" = "org.gnome.Totem.desktop";
            "application/mxf" = "org.gnome.Totem.desktop";
            "application/ram" = "org.gnome.Totem.desktop";
            "application/sdp" = "org.gnome.Totem.desktop";
            "application/vnd.ms-asf" = "org.gnome.Totem.desktop";
            "application/vnd.ms-wpl" = "org.gnome.Totem.desktop";
            "application/vnd.rn-realmedia" = "org.gnome.Totem.desktop";
            "application/vnd.rn-realmedia-vbr" = "org.gnome.Totem.desktop";
            "application/x-extension-m4a" = "org.gnome.Totem.desktop";
            "application/x-extension-mp4" = "org.gnome.Totem.desktop";
            "application/x-flash-video" = "org.gnome.Totem.desktop";
            "application/x-matroska" = "org.gnome.Totem.desktop";
            "application/x-netshow-channel" = "org.gnome.Totem.desktop";
            "application/x-quicktimeplayer" = "org.gnome.Totem.desktop";
            "application/x-shorten" = "org.gnome.Totem.desktop";
            "image/vnd.rn-realpix" = "org.gnome.Totem.desktop";
            "image/x-pict" = "org.gnome.Totem.desktop";
            "misc/ultravox" = "org.gnome.Totem.desktop";
            "text/x-google-video-pointer" = "org.gnome.Totem.desktop";
            "video/3gp" = "org.gnome.Totem.desktop";
            "video/3gpp" = "org.gnome.Totem.desktop";
            "video/3gpp2" = "org.gnome.Totem.desktop";
            "video/dv" = "org.gnome.Totem.desktop";
            "video/divx" = "org.gnome.Totem.desktop";
            "video/fli" = "org.gnome.Totem.desktop";
            "video/flv" = "org.gnome.Totem.desktop";
            "video/mp2t" = "org.gnome.Totem.desktop";
            "video/mp4" = "org.gnome.Totem.desktop";
            "video/mp4v-es" = "org.gnome.Totem.desktop";
            "video/mpeg" = "org.gnome.Totem.desktop";
            "video/mpeg-system" = "org.gnome.Totem.desktop";
            "video/msvideo" = "org.gnome.Totem.desktop";
            "video/ogg" = "org.gnome.Totem.desktop";
            "video/quicktime" = "org.gnome.Totem.desktop";
            "video/vivo" = "org.gnome.Totem.desktop";
            "video/vnd.avi" = "org.gnome.Totem.desktop";
            "video/vnd.divx" = "org.gnome.Totem.desktop";
            "video/vnd.rn-realvideo" = "org.gnome.Totem.desktop";
            "video/vnd.vivo" = "org.gnome.Totem.desktop";
            "video/webm" = "org.gnome.Totem.desktop";
            "video/x-anim" = "org.gnome.Totem.desktop";
            "video/x-avi" = "org.gnome.Totem.desktop";
            "video/x-flc" = "org.gnome.Totem.desktop";
            "video/x-fli" = "org.gnome.Totem.desktop";
            "video/x-flic" = "org.gnome.Totem.desktop";
            "video/x-flv" = "org.gnome.Totem.desktop";
            "video/x-m4v" = "org.gnome.Totem.desktop";
            "video/x-matroska" = "org.gnome.Totem.desktop";
            "video/x-mjpeg" = "org.gnome.Totem.desktop";
            "video/x-mpeg" = "org.gnome.Totem.desktop";
            "video/x-mpeg2" = "org.gnome.Totem.desktop";
            "video/x-ms-asf" = "org.gnome.Totem.desktop";
            "video/x-ms-asf-plugin" = "org.gnome.Totem.desktop";
            "video/x-ms-asx" = "org.gnome.Totem.desktop";
            "video/x-msvideo" = "org.gnome.Totem.desktop";
            "video/x-ms-wm" = "org.gnome.Totem.desktop";
            "video/x-ms-wmv" = "org.gnome.Totem.desktop";
            "video/x-ms-wmx" = "org.gnome.Totem.desktop";
            "video/x-ms-wvx" = "org.gnome.Totem.desktop";
            "video/x-nsv" = "org.gnome.Totem.desktop";
            "video/x-ogm+ogg" = "org.gnome.Totem.desktop";
            "video/x-theora" = "org.gnome.Totem.desktop";
            "video/x-theora+ogg" = "org.gnome.Totem.desktop";
            "video/x-totem-stream" = "org.gnome.Totem.desktop";
            "audio/x-pn-realaudio" = "org.gnome.Totem.desktop";
            "application/smil" = "org.gnome.Totem.desktop";
            "application/smil+xml" = "org.gnome.Totem.desktop";
            "application/x-quicktime-media-link" = "org.gnome.Totem.desktop";
            "application/x-smil" = "org.gnome.Totem.desktop";
            "text/google-video-pointer" = "org.gnome.Totem.desktop";
            "x-content/video-dvd" = "org.gnome.Totem.desktop";
            "x-scheme-handler/pnm" = "org.gnome.Totem.desktop";
            "x-scheme-handler/mms" = "org.gnome.Totem.desktop";
            "x-scheme-handler/net" = "org.gnome.Totem.desktop";
            "x-scheme-handler/rtp" = "org.gnome.Totem.desktop";
            "x-scheme-handler/rtmp" = "org.gnome.Totem.desktop";
            "x-scheme-handler/rtsp" = "org.gnome.Totem.desktop";
            "x-scheme-handler/mmsh" = "org.gnome.Totem.desktop";
            "x-scheme-handler/uvox" = "org.gnome.Totem.desktop";
            "x-scheme-handler/icy" = "org.gnome.Totem.desktop";
            "x-scheme-handler/icyx" = "org.gnome.Totem.desktop";

            "image/jpeg" = "org.gnome.Loupe.desktop";
            "image/png" = "org.gnome.Loupe.desktop";
            "image/gif" = "org.gnome.Loupe.desktop";
            "image/webp" = "org.gnome.Loupe.desktop";
            "image/tiff" = "org.gnome.Loupe.desktop";
            "image/x-tga" = "org.gnome.Loupe.desktop";
            "image/vnd-ms.dds" = "org.gnome.Loupe.desktop";
            "image/x-dds" = "org.gnome.Loupe.desktop";
            "image/bmp" = "org.gnome.Loupe.desktop";
            "image/vnd.microsoft.icon" = "org.gnome.Loupe.desktop";
            "image/vnd.radiance" = "org.gnome.Loupe.desktop";
            "image/x-exr" = "org.gnome.Loupe.desktop";
            "image/x-portable-bitmap" = "org.gnome.Loupe.desktop";
            "image/x-portable-graymap" = "org.gnome.Loupe.desktop";
            "image/x-portable-pixmap" = "org.gnome.Loupe.desktop";
            "image/x-portable-anymap" = "org.gnome.Loupe.desktop";
            "image/x-qoi" = "org.gnome.Loupe.desktop";
            "image/qoi" = "org.gnome.Loupe.desktop";
            "image/svg+xml" = "org.gnome.Loupe.desktop";
            "image/svg+xml-compressed" = "org.gnome.Loupe.desktop";
            "image/avif" = "org.gnome.Loupe.desktop";
            "image/heic" = "org.gnome.Loupe.desktop";
            "image/jxl" = "org.gnome.Loupe.desktop";
        };
    };
}
