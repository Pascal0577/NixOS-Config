{ pkgs, ... }:

{
  home.packages = with pkgs; [
    quarto
  ];

  programs.nixvim = {
    plugins = {
      treesitter.settings.highlight.enable = true;
      otter.enable = true;
      quarto = {
        enable = true;
        settings = {
          codeRunner = {
            default_method = "molten";
            enabled = false;
          };
          debug = false;
          lspFeatures = {
            enabled = true;
            completion.enabled = true;
            chunks = "curly";
            diagnostics = {
              enabled = true;
              triggers = [ "BufWritePost" ];
            };
          };
        };
      };
    };
  };
}
