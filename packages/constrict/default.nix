{
    lib,
    stdenv,
    fetchFromGitHub,
    meson,
    ninja,
    check,
    python3,
    ffmpeg-full,
    gettext,
    blueprint-compiler,
    pkg-config,
    glib,
    gtk4,
    desktop-file-utils,
    glycin-loaders,
    gobject-introspection,
    wrapGAppsHook4,
    libglycin,
    libadwaita,
    totem,
    libva-utils,
}:

stdenv.mkDerivation {
    pname = "constrict";
    version = "25.12";

    src = fetchFromGitHub {
        owner = "Wartybix";
        repo = "Constrict";
        rev = "25.12";
        sha256 = "1bhkirza65vpb9xzi97dwqidf1v6q06j0jcprfb33rvajksgd1yr";
    };

    buildInputs = [
        check
        totem
        libva-utils
        glycin-loaders
        ffmpeg-full
        (python3.withPackages (ps: with ps; [
            pygobject3
        ]))
        glib
        gtk4
        libglycin
        libadwaita
    ];

    nativeBuildInputs = [
        meson
        ninja
        pkg-config
        gettext
        blueprint-compiler
        desktop-file-utils
        gobject-introspection
        wrapGAppsHook4
    ];

    preFixup = ''
        gappsWrapperArgs+=(
            --prefix PATH : "${lib.makeBinPath [ ffmpeg-full ]}"
            --prefix XDG_DATA_DIRS : "${glycin-loaders}/share"
        )
    '';

    enableParallelBuilding = true;

    # Fixes the desktop file
    postInstall = ''
        desktopFile=$(find $out/share/applications -name "*.desktop")

        substituteInPlace $desktopFile --replace "Exec=constrict --new-window %U" "Exec=constrict %U"
        substituteInPlace $desktopFile --replace "Exec=constrict --new-window" "Exec=constrict"
        substituteInPlace $desktopFile --replace "DBusActivatable=true" "DBusActivatable=false"

        mv $out/share/applications/io.github.wartybix.Constrict.desktop \
          $out/share/applications/constrict.desktop
    '';

    meta = {
        description = "Compresses your videos to your chosen file size";
        license = lib.licenses.gpl3;
        platforms = lib.platforms.linux;
    };
}
