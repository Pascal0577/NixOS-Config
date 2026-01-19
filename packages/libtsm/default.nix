{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
, pkg-config
, libxkbcommon
, check
,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "libtsm";
  version = "4.4.0";

  src = fetchFromGitHub {
    owner = "kmscon";
    repo = "libtsm";
    tag = "v${finalAttrs.version}";
    hash = "sha256-xrZNVx9Ir9MCyXiV/cWLdjL2R9KNARY0sFpD5jUlP20=";
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
})
