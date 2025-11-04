{ lib, config, username, ... }:

{
    config = lib.mkIf config.mySystem.neovim.nord-theme.enable {
        home-manager.users.${username}.programs.nixvim.colorschemes.nord = {
            enable = true;
            settings = {
                borders = true;
                contrast = true;
            };
        };
    };
}
