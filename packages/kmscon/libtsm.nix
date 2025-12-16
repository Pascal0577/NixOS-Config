{
    lib,
    stdenv,
    fetchFromGitHub,
    meson,
    ninja,
    pkg-config,
    libxkbcommon,
    check,
}:

stdenv.mkDerivation {
    pname = "libtsm";
    version ="4.3.0";

    src = fetchFromGitHub {
        owner = "Aetf";
        repo = "libtsm";
        rev = "v4.3.0";
        sha256 = "0nryrzvphf878y9lpgx3zbm126qqnf4y65qv3rvzhpdj00w100y4";
    };

    buildInputs = [
        check
        libxkbcommon
    ];

    nativeBuildInputs = [
        meson
        ninja
        pkg-config
    ];

    enableParallelBuilding = true;

    meta = {
        description = "Terminal state machine library";
        license = lib.licenses.mit;
        platforms = lib.platforms.linux;
    };
}
