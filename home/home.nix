{ pkgs, ... }:

{
  imports = [ 
    ./modules/zen-browser.nix
    ./modules/gnome.nix
    ./modules/neovim.nix
    ./modules/git.nix
    ./modules/shell.nix
    ./modules/ghostty.nix
    ./modules/discord.nix
    ./modules/obs-studio.nix
    ./modules/fastfetch.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "pascal";
  home.homeDirectory = "/home/pascal";

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "25.05";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    ghostty
    celluloid

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.

  fonts.fontconfig.enable = true;

  home.file = {
  };

  home.sessionVariables = {
  };

  programs = {
    home-manager.enable = true;
  };
}
