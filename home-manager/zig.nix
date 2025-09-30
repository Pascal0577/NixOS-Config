{ pkgs, ... }:

{
  programs.nixvim.plugins.lsp.servers = {
    zls.enable = true;
  };

  home.packages = with pkgs; [
    zig
    zig-shell-completions
  ];
}
