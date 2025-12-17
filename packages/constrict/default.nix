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
    libadwaita,
    libglycin,
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
        glycin-loaders
        ffmpeg-full
        (python3.withPackages (ps: with ps; [
            pygobject3
        ]))
        glib
        gtk4
        libadwaita
        libglycin
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

    # Make ffmpeg tools available at runtime and configure glycin loaders
    preFixup = ''
        gappsWrapperArgs+=(
            --prefix PATH : "${lib.makeBinPath [ ffmpeg-full ]}"
            --prefix XDG_DATA_DIRS : "${glycin-loaders}/share"
        )
    '';

    enableParallelBuilding = true;

    meta = {
        description = "Compresses your videos to your chosen file size";
        license = lib.licenses.gpl3;
        platforms = lib.platforms.linux;
    };
}
