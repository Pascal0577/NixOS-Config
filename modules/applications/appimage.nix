{ pkgs, config, lib, ... }:

{
    options.mySystem.applications.appimage.enable =
        lib.mkEnableOption "AppImage module"
        // { default = !config.mySystem.server.enable; };

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
