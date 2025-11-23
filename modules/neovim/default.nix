{ inputs, pkgs, config, lib, username, ... }:

{
    imports = [
        ./ghostty-theme.nix
        ./nord.nix        
    ];

    config = lib.mkIf config.mySystem.neovim.enable {
        home-manager.users.${username} = {
            imports = [
                inputs.nixvim.homeModules.nixvim
            ];

            home.packages = with pkgs; [
                quarto
                (writeShellScriptBin "nvim-wrapper" ''
                    exec ${"$"}TERMINAL -e nvim "$@"
                '')
            ];

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
                };

                keymaps = [
                    {
                        mode = "n";
                        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
                        key = "<leader>do";
                        options.desc = "Open diagnostic";
                    }
                    {
                        mode = "n";
                        action = "<cmd>Telescope find_files<CR>";
                        key = "<leader>ff";
                        options.desc = "Telescope fine files";
                    }
                    {
                        mode = "n";
                        action = "<cmd>silent !zig fmt %<CR>";
                        key = "<leader>zf";
                        options.desc = "Format Zig file";
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
                        action = "<cmd>vertical resize -10<CR>";
                        key = "<C-[>";
                    }
                    {
                        mode = "n";
                        action = "<cmd>vertical resize +10<CR>";
                        key = "<C-]>";
                    }
                ];

                plugins = {
                    lsp = {
                        enable = true;
                        servers = { 
                            bashls.enable = true;
                            nixd.enable = true;
                        };
                    };

                    blink-cmp = {
                        enable = true;
                        setupLspCapabilities = true;
                        settings = {
                            appearance = {
                                nerd_font_variant = "mono";
                            };
                            completion = {
                                menu.border = "none";
                                accept = {
                                    auto_brackets = {
                                        enabled = false;
                                        semantic_token_resolution = {
                                            enabled = false;
                                        };
                                    };
                                };
                                documentation = {
                                    auto_show = false;
                                };
                            };
                            keymap = {
                                preset = "super-tab";
                            };
                            signature = {
                                enabled = true;
                            };
                            sources = {
                                cmdline = [ ];
                                providers = {
                                    buffer = {
                                        score_offset = -7;
                                    };
                                    lsp = {
                                        fallbacks = [ ];
                                    };
                                };
                            };
                        };
                    };

                    indent-blankline = {
                        enable = true;
                        settings = {
                            indent = {
                                char = "│";
                            };

                        };
                    };

                    treesitter = {
                        enable = true;
                        settings = {
                            highlight.enable = true;
                            auto_install = true;
                        };
                    };

                    nvim-tree = {
                        enable = true;
                        settings = {
                            tab = {
                                sync = {
                                    open = true;
                                };
                            };
                        };
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
                        standalonePlugins = [
                            pkgs.vimPlugins.nord-nvim
                            pkgs.vimPlugins.blink-cmp
                        ];
                    };
                };
            };

            home.sessionVariables.EDITOR = "nvim";

            xdg.desktopEntries.nvim = {
                name = "Neovim";
                genericName = "Text Editor";
                comment = "Edit text files";
                exec = "nvim-wrapper %F";
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
    };
}
