{ pkgs, username, ... }:

{
    environment.systemPackages = with pkgs; [
        zig
        zig-shell-completions
    ];

    home-manager.users.${username}.programs.nixvim = {
        plugins.lsp.servers.zls.enable = true;

        keymaps = [
            {
                mode = "n";
                action = "<cmd>silent !zig fmt %<CR>";
                key = "<leader>zf";
                options.desc = "Format Zig file";
            }
        ];
    };
}
