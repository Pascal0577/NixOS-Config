{ pkgs, ... }:

{
    programs.appimage = {
        enable = true;
        binfmt = true;
        package = pkgs.appimage-run.override { extraPkgs = pkgs: with pkgs; [
            libxcrypt
            libxcrypt-legacy
            libffi
            libyaml
            icu
        ];};
    };
}
