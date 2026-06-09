{
  stdenvNoCC,
  fetchFromGitHub,
  fetchYarnDeps,
  lib,
  nodejs,
  yarn,
  yarnConfigHook,
  cbmp,
  chromium,
  clickgen,
}:

let
  customColors = [
    { name = "Gruvbox"; bc = "#282828"; oc = "#EBDBB2"; }
  ];
in
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "google-cursor";
  version = "2.0.0";

  # Fetch the source repo (needed for SVGs + build.toml + ctgen)
  src = fetchFromGitHub {
    owner = "ful1e5";
    repo  = "Google_Cursor";
    rev   = "v${finalAttrs.version}";
    hash  = "sha256-vzNtm3gwkGjHlC2G7dTsieQLOu67GnB3BIUSD6pZ6AA=";
  };

  offlineCache = fetchYarnDeps {
    yarnLock = finalAttrs.src + "/yarn.lock";
    hash = "sha256-NKIZomumpaVJ55ssHWkXzwU4SV646cJGS6xAK0b3OAk=";
  };

  nativeBuildInputs = [ nodejs yarn yarnConfigHook cbmp chromium clickgen ];

  env = {
    PUPPETEER_SKIP_DOWNLOAD = "true";
    PUPPETEER_EXECUTABLE_PATH = "${chromium}/bin/chromium";
  };

  buildPhase = ''
    ${lib.concatMapStrings (c: ''
      npx cbmp -d svg -n 'GoogleDot-${c.name}' -bc '${c.bc}' -oc '${c.oc}'
      ctgen build.toml \
        -d "bitmaps/GoogleDot-${c.name}" \
        -n "GoogleDot-${c.name}" \
        -c "Custom GoogleDot-${c.name} cursors."
    '') customColors}
  '';

  installPhase = ''
    mkdir -p $out/share/icons

    ${lib.concatMapStrings (c: ''
      cp -r themes/GoogleDot-${c.name} $out/share/icons/
    '') customColors}
  '';
})
