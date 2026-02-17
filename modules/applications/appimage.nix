{ pkgs, config, lib, ... }:

{
    options.mySystem.applications.appimage.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable my AppImage module";
    };

    config = lib.mkIf config.mySystem.applications.appimage.enable {
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
