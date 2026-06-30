{ pkgs, lib, config, ... }:

{
    options.mySystem.applications.gtk-apps.enable =
        lib.mkEnableOption "Common GTK apps module"
        // { default = !config.mySystem.server.enable; };

    config = let
        imageViewer = "org.gnome.Loupe.desktop";
        audioPlayer = "org.gnome.Decibels.desktop";

        imageMimes = [
            "image/apng"
            "image/avif"
            "image/avif-sequence"
            "image/bmp"
            "image/cgm"
            "image/g3fax"
            "image/gif"
            "image/heic"
            "image/ief"
            "image/jp2"
            "image/jpeg"
            "image/jxl"
            "image/pjpeg"
            "image/png"
            "image/prs.btif"
            "image/svg+xml"
            "image/svg+xml-compressed"
            "image/qoi"
            "image/tiff"
            "image/vnd.fpx"
            "image/vnd.microsoft.icon"
            "image/vnd.wap.wbmp"
            "image/vnd.xiff"
            "image/webp"
            "image/x-adobe-dng"
            "image/x-canon-cr2"
            "image/x-canon-crw"
            "image/x-cmu-raster"
            "image/x-cmx"
            "image/x-dds"
            "image/x-epson-erf"
            "image/x-exr"
            "image/x-freehand"
            "image/x-fuji-raf"
            "image/x-icns"
            "image/x-icon"
            "image/x-kodak-dcr"
            "image/x-kodak-k25"
            "image/x-kodak-kdc"
            "image/x-minolta-mrw"
            "image/x-nikon-nef"
            "image/x-olympus-orf"
            "image/x-panasonic-raw"
            "image/x-pcx"
            "image/x-pentax-pef"
            "image/x-pict"
            "image/x-portable-anymap"
            "image/x-portable-bitmap"
            "image/x-portable-graymap"
            "image/x-portable-pixmap"
            "image/x-qoi"
            "image/x-rgb"
            "image/x-sigma-x3f"
            "image/x-sony-arw"
            "image/x-sony-sr2"
            "image/x-sony-srf"
            "image/x-tga"
            "image/x-win-bitmap"
            "image/x-xbitmap"
            "image/x-xpixmap"
            "image/x-xwindowdump"
        ];

        imageBindings = lib.genAttrs imageMimes (_: imageViewer);

        audioMimes = [
            "application/ogg"
            "application/x-extension-m4a"
            "application/x-flac"
            "application/x-ogg"
            "audio/3gpp"
            "audio/3gpp2"
            "audio/aac"
            "audio/aacp"
            "audio/ac3"
            "audio/adpcm"
            "audio/aiff"
            "audio/amr"
            "audio/amr-wb"
            "audio/basic"
            "audio/dv"
            "audio/eac3"
            "audio/flac"
            "audio/m4a"
            "audio/midi"
            "audio/mp1"
            "audio/mp2"
            "audio/mp3"
            "audio/mp4"
            "audio/mp4a-latm"
            "audio/mpeg"
            "audio/mpegurl"
            "audio/mpg"
            "audio/ogg"
            "audio/opus"
            "audio/scpls"
            "audio/vnd.dolby.heaac.1"
            "audio/vnd.dolby.heaac.2"
            "audio/vnd.dolby.mlp"
            "audio/vnd.dts"
            "audio/vnd.dts.hd"
            "audio/vnd.rn-realaudio"
            "audio/vnd.wav"
            "audio/wav"
            "audio/wave"
            "audio/webm"
            "audio/x-aac"
            "audio/x-aiff"
            "audio/x-ape"
            "audio/x-flac"
            "audio/x-gsm"
            "audio/x-it"
            "audio/x-m4a"
            "audio/x-m4b"
            "audio/x-matroska"
            "audio/x-mod"
            "audio/x-mp1"
            "audio/x-mp2"
            "audio/x-mp3"
            "audio/x-mpg"
            "audio/x-mpeg"
            "audio/x-mpegurl"
            "audio/x-mpg"
            "audio/x-ms-asf"
            "audio/x-ms-wax"
            "audio/x-ms-wma"
            "audio/x-musepack"
            "audio/x-opus+ogg"
            "audio/x-pn-aiff"
            "audio/x-pn-au"
            "audio/x-pn-realaudio"
            "audio/x-pn-wav"
            "audio/x-real-audio"
            "audio/x-realaudio"
            "audio/x-s3m"
            "audio/x-scpls"
            "audio/x-shorten"
            "audio/x-speex"
            "audio/x-tta"
            "audio/x-vorbis"
            "audio/x-vorbis+ogg"
            "audio/x-wav"
            "audio/x-wavpack"
            "audio/x-xm"
            "x-content/audio-cdda"
            "x-content/audio-player"
        ];

        audioBindings = lib.genAttrs audioMimes (_: audioPlayer);
    in lib.mkIf config.mySystem.applications.gtk-apps.enable {
        environment.sessionVariables = { GSK_RENDERER = "gl"; };
        environment.systemPackages = with pkgs; [
            loupe
            decibels
            baobab
            constrict
            curtail
            deluge
            pinta
            blanket
            video-trimmer
        ];

        xdg.mime.defaultApplications = {} //
            imageBindings //
            audioBindings;
    };
}
