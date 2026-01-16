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
    version = "25.12.1";

    src = fetchFromGitHub {
        owner = "Wartybix";
        repo = "Constrict";
        rev = "25.12.1";
        sha256 = "1d5lf7kn9lf38ci774sfsabpjh3szrwqzspxzcrsj5fdx2aq2a35";
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

    meta = {
        description = "Compresses your videos to your chosen file size";
        license = lib.licenses.gpl3;
        platforms = lib.platforms.linux;
    };
}
