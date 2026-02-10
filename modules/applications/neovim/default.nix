{ inputs, pkgs, username, config, ... }:

{
    imports = [
        ./latex.nix
        ./zig.nix
    ];

    home-manager.users.${username} = {
        imports = [ inputs.nixvim.homeModules.nixvim ];

        programs.nixvim = {
            enable = true;
            globals.mapleader = " ";
            opts = {
                number = true;
                relativenumber = true;
                nu = true;
                tabstop = 4;
                softtabstop = 4;
                shiftwidth = 4;
                expandtab = true;
                smartindent = true;
                hlsearch = true;
                incsearch = true;
                scrolloff = 8;
                signcolumn = "yes";
                winborder = "rounded";
                swapfile = false;
                linebreak = true;
                laststatus = 3;
            };

            keymaps = [
                {
                    mode = "n";
                    action = "<cmd>lua vim.diagnostic.open_float()<CR>";
                    key = "<leader>do";
                    options.desc = "Diagnostic Open";
                }
                {
                    mode = "n";
                    action = "<cmd>lua vim.diagnostic.open_float()<CR>";
                    key = "<leader>dg";
                    options.desc = "Go to definition";
                }
                {
                    mode = "n";
                    action = "<cmd>Telescope find_files<CR>";
                    key = "<leader>ff";
                    options.desc = "Telescope find files";
                }
                {
                    mode = "n";
                    action = "<cmd>lua require('telescope.builtin').lsp_document_symbols({ symbols='function' })<CR>";
                    key = "<leader>fs";
                    options.desc = "Telescope find functions";
                }
                {
                    mode = "n";
                    action = "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols({ symbols='function' })<CR>";
                    key = "<leader>fw";
                    options.desc = "Telescope find workspace symbols";
                }
                {
                    mode = "n";
                    action = "<cmd>tabnext<CR>";
                    key = "<leader>tt";
                    options.desc = "Go to next tab";
                }
                {
                    mode = "n";
                    action = "<cmd>tabprevious<CR>";
                    key = "<leader>tr";
                    options.desc = "Go to previous tab";
                }
                {
                    mode = "n";
                    action = "<cmd>NvimTreeToggle<CR>";
                    key = "<leader>ntt";
                }
                {
                    mode = "n";
                    action = "<cmd>NvimTreeFocus<CR>";
                    key = "<leader>ntf";
                }
                {
                    mode = "n";
                    action = "<cmd>vertical resize -5<CR>";
                    key = "<C-;>";
                }
                {
                    mode = "n";
                    action = "<cmd>vertical resize +5<CR>";
                    key = "<C-'>";
                }
                {
                    mode = "n";
                    action = "<cmd>below 10split | terminal<CR>";
                    key = "<leader>to";
                }
            ];

            plugins = {
                lsp = {
                    enable = true;
                    servers = { 
                        bashls.enable = true;
                        nixd.enable = true;
                    };
                    # highlights instances of functions/variables/etc
                    onAttach = ''
                        if client.server_capabilities.documentHighlightProvider then
                            local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
                            vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })

                            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                                buffer = bufnr,
                                group = group,
                                callback = function()
                                    vim.lsp.buf.clear_references()
                                    vim.lsp.buf.document_highlight()
                                end,
                            })

                            vim.api.nvim_create_autocmd("BufLeave", {
                                buffer = bufnr,
                                group = group,
                                callback = vim.lsp.buf.clear_references,
                            })
                        end
                    '';
                };

                blink-cmp = {
                    enable = true;
                    setupLspCapabilities = true;
                    settings = {
                        appearance = {
                            nerd_font_variant = "mono";
                        };
                        completion = {
                            menu = {
                                border = "rounded";
                                draw = {
                                #    columns = [
                                #        [ "kind_icon" "kind" ]
                                #        [ "label" "label_description" ]
                                #    ];
                                    treesitter = [ "lsp" ];
                                };
                            };
                            ghost_text.enabled = false;
                            list.max_items = 500;
                            accept = {
                                auto_brackets = {
                                    enabled = true;
                                    semantic_token_resolution = {
                                        enabled = true;
                                    };
                                };
                            };
                            documentation = {
                                auto_show = true;
                                window.border = "rounded";
                            };
                        };
                        keymap.preset = "super-tab";
                        signature.enabled = true;
                        sources = {
                            providers = {
                                snippets.async = true;
                                buffer = {
                                    score_offset = -7;
                                    async = true;
                                };
                                lsp = {
                                    fallbacks = [ "buffer" ];
                                    async = true;
                                };
                            };
                        };
                    };
                };

                indent-blankline = {
                    enable = true;
                    settings.indent.char = "│";
                };

                treesitter = {
                    enable = true;
                    settings = {
                        highlight.enable = true;
                        auto_install = false;
                    };
                };

                nvim-tree = {
                    enable = true;
                    autoClose = false;
                    settings.tab.sync.open = true;
                };

                lualine.enable = true;
                web-devicons.enable = true;
                telescope.enable = true;
            };

            performance = {
                byteCompileLua = {
                    enable = true;
                    initLua = true;
                    luaLib = true;
                    nvimRuntime = true;
                    plugins = true;
                };

                combinePlugins = {
                    enable = true;
                    standalonePlugins = with pkgs.vimPlugins; [
                        blink-cmp
                    ];
                };
            };
        };

        home.sessionVariables.EDITOR = "nvim";

        xdg.desktopEntries.nvim = {
            name = "Neovim";
            genericName = "Text Editor";
            comment = "Edit text files";
            exec = "${config.terminalRunCommand} nvim %F";
            terminal = false;
            icon = "nvim";
            categories = [ "Utility" "TextEditor" ];
            type = "Application";
            mimeType = [
                "text/english"
                "text/plain"
                "text/x-makefile"
                "text/x-c++hdr"
                "text/x-c++src"
                "text/x-chdr"
                "text/x-csrc"
                "text/x-java"
                "text/x-moc"
                "text/x-pascal"
                "text/x-tcl"
                "text/x-tex"
                "application/x-shellscript"
                "text/x-c"
                "text/x-c++"
            ];
        };
    };
}
