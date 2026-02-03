{ pkgs, username, ... }:

{
    environment.systemPackages = [
        pkgs.texliveMedium
        pkgs.zathura
    ];

    home-manager.users.${username} = {
        programs.nixvim = {
            plugins.vimtex = {
                enable = true;
                settings.view_method = "zathura";
            };

            lsp.servers.texlab.enable = true;

            keymaps = [
                {
                    mode = "n";
                    action = "<cmd>VimtexCompile<CR>";
                    key = "<leader>vc";
                    options.desc = "Compile LaTeX document";
                }
            ];
        };
    };
}
