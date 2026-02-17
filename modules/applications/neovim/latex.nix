{ pkgs, username, config, lib, ... }:

{
    options.mySystem.applications.neovim.enableLatex = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable latex editing for my neovim module";
    };

    config = lib.mkIf config.mySystem.applications.neovim.enableLatex {
        environment.systemPackages = with pkgs; [
            texliveMedium
            zathura
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
    };
}
