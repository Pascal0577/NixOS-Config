{
    stdenvNoCC,
    lib,
    zig,
}:

stdenvNoCC.mkDerivation {
    pname = "renameat2";
    version = "1.0.0";

    src = lib.cleanSource ./.;

    nativeBuildInputs = [ zig ];

    dontConfigure = true;

    buildPhase = ''
        runHook preBuild
        export ZIG_GLOBAL_CACHE_DIR=$TMPDIR/zig-cache
        export ZIG_LOCAL_CACHE_DIR=$TMPDIR/zig-cache
        zig build-exe main.zig -O ReleaseSafe -femit-bin=renameat2
        runHook postBuild
    '';

    installPhase = ''
        runHook preInstall
        mkdir -p $out/bin
        cp renameat2 $out/bin/
        runHook postInstall
    '';

    meta = with lib; {
        description = "renameat2-based file exchange tool";
        platforms = platforms.linux;
        mainProgram = "renameat2";
    };
}
