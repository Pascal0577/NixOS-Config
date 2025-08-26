{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    fzf
    eza
    zoxide
    zsh
  ];

  home.sessionVariables = {
    SHELL = "/home/pascal/.nix-profile/bin/zsh";
  };

  # home.file = {
  #   ".config/ghostty/config".text = ''
  #     command = zsh
  #   '';
  # };

  programs = {
    fzf.enableZshIntegration = true;
    eza.enableZshIntegration = true;
    zoxide.enableZshIntegration = true;
    ghostty.enableZshIntegration = true;
   
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;

      history = {
        size = 1000;
        save = 1000;
        path = "${config.xdg.dataHome}/zsh/history";
        share = true;
        ignoreSpace = true;
        ignoreAllDups = true;
        saveNoDups = true;
        expireDuplicatesFirst = true;
      };

      initContent = ''
        # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
        # Initialization code that may require console input (password prompts, [y/n]
        # confirmations, etc.) must go above this block; everything else may go below.
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi

        # Set the directory we want to store zinit and plugins
        ZINIT_HOME="''${XDG_DATA_HOME:-''${HOME}/.local/share}/zinit/zinit.git"

	# Install zinit if it's not already present
        if [ ! -f "$ZINIT_HOME/zinit.zsh" ]; then
          mkdir -p "$(dirname "$ZINIT_HOME")"
          git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
        fi

        # Source/Load zinit
        source "''${ZINIT_HOME}/zinit.zsh"

        # Add in Powerlevel10k
        zinit ice depth=1; zinit light romkatv/powerlevel10k

        # Add in zsh plugins
        zinit light Aloxaf/fzf-tab
	zinit light zdharma-continuum/fast-syntax-highlighting
	# zinit light zsh-users/zsh-completions
        # zinit light zsh-users/zsh-autosuggestions

        # Add in snippets
        # zinit snippet OMZL::git.zsh
        # zinit snippet OMZP::git
        # zinit snippet OMZP::command-not-found

        # Load completions
        # autoload -Uz compinit && compinit

        zinit cdreplay -q

        # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

        bindkey -e
        bindkey '^p' history-search-backward
        bindkey '^n' history-search-forward
        bindkey '^[w' kill-region

        # Completion styling
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
        zstyle ':fzf-tab:complete:eza:*' fzf-preview 'ls --color $realpath'
        zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
        zstyle ':fzf-tab:complete:z:*' fzf-preview 'ls --color $realpath'

        alias ls='eza --color=always --icons=always --group-directories-first -a'
        alias lsl='eza --color=always --icons=always --group-directories-first -lAh --total-size'
        alias nviz='nvim $(fzf)'

        eval "$(fzf --zsh)"
        eval "$(zoxide init zsh)"
      '';

    };
  };
}
