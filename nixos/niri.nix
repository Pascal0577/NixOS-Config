{ inputs, pkgs, lib, ... }:
let
  niri-blur = pkgs.niri-unstable.overrideAttrs (oldAttrs: {
      src = pkgs.fetchFromGitHub {
          owner = "visualglitch91";
          repo = "niri";
          rev = "feat/blur";
          hash = "sha256-sNAJQBP2rVL5OM6Lnblmy7EWYRsrZnmuQnnip4mX8mQ=";  # You'll need to update this
      };
      doCheck = false;
      version = "niri-unstable-blur";
  });
in
{
    imports = [
        inputs.niri.nixosModules.niri
    ];

    nixpkgs.overlays = [ inputs.niri.overlays.niri ];

    programs.niri = {
        enable = true;
        package = niri-blur;
    };
    niri-flake.cache.enable = true;
}
