{ pkgs, ... }:
let
    mathematica-cuda-new = pkgs.mathematica-webdoc.override {
        source = pkgs.requireFile {
            name = "Wolfram_14.3.0_LIN.sh";
            # Get this hash via a command similar to this:
            # nix-store --query --hash \
            # $(nix store add-path Mathematica_XX.X.X_BNDL_LINUX.sh --name 'Mathematica_XX.X.X_BNDL_LINUX.sh')
            sha256 = "18a8wf9j6n4dp631psa254hyniklm61i3qqrvvnz1sgfvd1hl6cf";
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
