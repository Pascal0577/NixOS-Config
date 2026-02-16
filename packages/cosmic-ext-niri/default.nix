{
    lib,
    fetchFromGitHub,
    fetchgit,
    rustPlatform,
    just,
}:
let
    # The actual Rust binary lives in the submodule, not the parent repo
    rustSrc = fetchFromGitHub {
        owner = "drakulix";
        repo = "cosmic-ext-alternative-startup";
        rev = "d6884f0d4dd20fcae73e662c13e000bb90bb45f3";
        hash = "sha256-Y8xWJ8VtShczKZ1YexwYrRIJaEACzOZ0DgcFQ8lzj+8=";
    };

    # The parent repo only provides session/config files
    sessionSrc = fetchgit {
        url = "https://github.com/Drakulix/cosmic-ext-extra-sessions";
        # rev = 
        hash = "sha256-uSkxcYztCVWPwdX1q/JDK1/psUmB5/8zLhYQcDp8Dg4=";
    };
in
rustPlatform.buildRustPackage {
    pname = "cosmic-ext-sessions";
    version = "git";

    src = rustSrc;

    cargoHash = "sha256-DeMkAG2iINGden0Up013M9mWDN4QHrF+FXoNqpGB+mg=";
    nativeBuildInputs = [ just ];

    installPhase = ''
        runHook preInstall
        install -Dm0755 target/release/cosmic-ext-alternative-startup $out/bin/cosmic-ext-alternative-startup
        
        mkdir -p $out/share/wayland-sessions
        substitute ${sessionSrc}/niri/cosmic-ext-niri.desktop $out/share/wayland-sessions/cosmic-ext-niri.desktop \
            --replace-fail "/usr/local/bin/start-cosmic-ext-niri" "$out/bin/start-cosmic-ext-niri"
        
        install -Dm0755 ${sessionSrc}/niri/start-cosmic-ext-niri $out/bin/start-cosmic-ext-niri
        runHook postInstall
    '';

    meta = {
        homepage = "https://github.com/Drakulix/cosmic-ext-extra-sessions";
        description = "Allows for alternative compositors with the COSMIC session";
        license = lib.licenses.gpl3;
        platforms = lib.platforms.linux;
    };
}
