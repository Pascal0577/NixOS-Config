{ pkgs, username, config, lib, ... }:

{
    options.applications.neovim.enableZig = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable zig editing for my neovim module";
    };

    config = lib.mkIf config.applications.neovim.enableZig {
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
    };
}
