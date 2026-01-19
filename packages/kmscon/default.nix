{ lib
, stdenv
, fetchFromGitHub
, meson
, systemdLibs
, libxkbcommon
, libdrm
, libGLU
, libGL
, pango
, pixman
, pkg-config
, docbook_xsl
, libxslt
, libgbm
, ninja
, check
, buildPackages
, pkgs
,
}:

let
  libtsm' = pkgs.callPackage ../libtsm/default.nix { };
in

stdenv.mkDerivation {
  pname = "kmscon";
  version = "9.2.1";

  src = fetchFromGitHub {
    owner = "kmscon";
    repo = "kmscon";
    tag = "v9.2.1";
    hash = "sha256-MuDqZDbZOrq4n/LxEupbBPIL1747iiHD6kM0SeX2Vzc=";
  };

  patches = [
    ./sandbox.patch # Generate system units where they should be (nix store) instead of /etc/systemd/system
  ];

  strictDeps = true;

  depsBuildBuild = [
    buildPackages.stdenv.cc
  ];

  buildInputs = [
    libGLU
    libGL
    libdrm
    libtsm'
    libxkbcommon
    pango
    pixman
    systemdLibs
    libgbm
    check
  ];

  nativeBuildInputs = [
    meson
    ninja
    docbook_xsl
    pkg-config
    libxslt # xsltproc
  ];

  env.NIX_CFLAGS_COMPILE =
    lib.optionalString stdenv.cc.isGNU "-O "
    + "-Wno-error=maybe-uninitialized -Wno-error=unused-result -Wno-error=implicit-function-declaration";

  meta = {
    description = "KMS/DRM based System Console";
    mainProgram = "kmscon";
    homepage = "https://www.freedesktop.org/wiki/Software/kmscon/";
    license = lib.licenses.mit;
    maintainers = [ ];
    platforms = lib.platforms.linux;
  };
}
