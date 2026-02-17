{ pkgs, config, lib, ... }:
let
    mathematica-new = pkgs.mathematica-webdoc.override {
        source = pkgs.requireFile {
            name = "Wolfram_14.3.0_LIN.sh";
            # Get this hash via a command similar to this:
            # nix-store --query --hash $(nix store add-path Wolfram_14.3.0_LIN.sh --name 'Wolfram_14.3.0_LIN.sh')
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
    options.mySystem.applications.mathematica.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable my Mathematica module";
    };

    config = lib.mkIf config.mySystem.applications.mathematica.enable {
        environment.systemPackages = [ mathematica-new ];
    };
}
