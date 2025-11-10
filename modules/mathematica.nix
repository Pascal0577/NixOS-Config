{ pkgs, ... }:
let
    mathematica-cuda-new = pkgs.mathematica-cuda.override {
      source = pkgs.requireFile {
        name = "Wolfram_14.3.0_LIN_Bndl.sh";
        # Get this hash via a command similar to this:
        # nix-store --query --hash \
        # $(nix store add-path Mathematica_XX.X.X_BNDL_LINUX.sh --name 'Mathematica_XX.X.X_BNDL_LINUX.sh')
        sha256 = "0zgl62wmrsrsza7835sl8jri8imwvlqcb303n9qpyayspjaqhhnb";
        message = ''
          Your override for Mathematica includes a different src for the installer,
          and it is missing.
        '';
        hashMode = "recursive";
      };
    };
in
{
    environment.systemPackages = [ mathematica-cuda-new ];
}
