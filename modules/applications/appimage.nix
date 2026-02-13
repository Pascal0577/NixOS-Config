{ pkgs, config, lib, ... }:

{
    options.applications.appimage.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        descripton = "Whether to enable my AppImage module";
    };

    config = lib.mkIf config.applications.appimage.enable {
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
    };
}
