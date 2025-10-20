{ pkgs, config, lib, username, ... }:

{
    environment.systemPackages = with pkgs; [
        zig
        zig-shell-completions
    ];
    
    home-manager.users.${username} = {
        programs.nixvim.plugins.lsp.servers = lib.mkIf config.mySystem.neovim.enable {
            zls.enable = true;
        };
    };
}
