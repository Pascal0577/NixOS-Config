{ pkgs, username, ... }:

{
    environment.systemPackages = with pkgs; [
        zig
        zig-shell-completions
    ];
    home-manager.users.${username}.programs.nixvim.plugins.lsp.servers.zls.enable = true;
}
