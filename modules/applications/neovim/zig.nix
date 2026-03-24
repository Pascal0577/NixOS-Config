{ pkgs, username, config, lib, ... }:
let
    nvim = config.mySystem.applications.neovim;
in
{
    options.mySystem.applications.neovim.enableZig =
        lib.mkEnableOption "Zig integration into Neovim" // { default = true; };

    config = lib.mkIf (nvim.enableZig && nvim.enable) {
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
