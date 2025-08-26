{ inputs, pkgs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  home.packages = with pkgs; [
    python313Packages.pylatexenc
  ];

  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox = {
      enable = true;
      settings = {
        transparent_mode = true;
        palette_overrides = {
          dark0_hard = "#1a1a1a";
          dark0 = "#202020";
          dark0_soft = "#2a2a2a";
          dark1 = "#3a3a3a";
          dark2 = "#4a4a4a";
          dark3 = "#5a5a5a";
          dark4 = "#6a6a6a";

          light0_hard = "#ffffff";
          light0 = "#e0e2ea";    
          light0_soft = "#e0e2ea";    
          light1 = "#d8dae0";    
          light2 = "#c0c2c8";
          light3 = "#a8aaae";
          light4 = "#909296";

          bright_red = "#cc6666";     
          bright_green = "#b5bd68";   
          bright_yellow = "#f0c674";  
          bright_blue = "#81a2be";  
          bright_purple = "#b294bb";  
          bright_aqua = "#8abeb7";  
          bright_orange = "#d08770";

          neutral_red = "#d54e53";  
          neutral_green = "#b9ca4a";  
          neutral_yellow = "#e7c547"; 
          neutral_blue = "#7aa6da"; 
          neutral_purple = "#c397d8"; 
          neutral_aqua = "#70c0b1"; 
          neutral_orange = "#de935f"; 

          faded_red = "#aa3c3f"; 
          faded_green = "#8da94a";    
          faded_yellow = "#c5b350";   
          faded_blue = "#5f8dbf";   
          faded_purple = "#9e7ca4";   
          faded_aqua = "#5a9c97";   
          faded_orange = "#b26e48";   

          dark_red_hard = "#5c2e30";
          dark_red = "#6e2f33";
          dark_red_soft = "#803b3f";
          light_red_hard = "#f8a3a0";
          light_red = "#f4a6a1";
          light_red_soft = "#f0a19a";

          dark_green_hard = "#4a5a30";
          dark_green = "#526432";
          dark_green_soft = "#5b6e38";
          light_green_hard = "#d0e0a0";
          light_green = "#c8da95";
          light_green_soft = "#c0d48a";

          dark_aqua_hard = "#3b4e44";
          dark_aqua = "#445850";
          dark_aqua_soft = "#4d625b";
          light_aqua_hard = "#cde7d9";
          light_aqua = "#d0e9dc";
          light_aqua_soft = "#d6ece0";

          gray = "#c5c8c6";
        }; 
      };
    };

    globals.mapleader = " ";
    
    opts = {
      number = true;
      relativenumber = true;
      nu = true;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      smartindent = true;
      hlsearch = true;
      incsearch = true;
      scrolloff = 8;
      signcolumn = "yes";
      winborder = "rounded";
      swapfile = false;
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
    ];
    plugins = {
      lsp = {
        enable = true;
        servers = { 
	        bashls.enable = true;
	        nixd.enable = true;
                zls.enable = true;
	      };
      };

      cmp = {
        enable = true;
	      autoEnableSources = true;
	      settings.sources = [
	        {name = "nvim_lsp";}
	        {name = "path";}
	        {name = "buffer";}
        ];
      };
      
      treesitter.enable = true;
      lualine.enable = true;
      web-devicons.enable = true;
      telescope.enable = true;
      render-markdown.enable = true;
    };
  };

  home.sessionVariables.EDITOR = "nvim";
}
