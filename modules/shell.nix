{ pkgs, username, ... }:

{
    environment.pathsToLink = [ "/share/zsh" ];
    programs.zsh.enable = true;
    users.users.${username}.shell = pkgs.zsh;
    home-manager.users.${username} = {
        home.packages = with pkgs; [
            fzf
            eza
            zoxide
            bat
            glow
            poppler-utils
        ];

        programs = {
            fzf.enableZshIntegration = true;
            eza.enableZshIntegration = true;
            zoxide.enableZshIntegration = true; 
            
            zsh = {
                enable = true;
                autosuggestion.enable = true;
                enableCompletion = true;
                history = {
                    size = 1000;
                    save = 1000;
                    path = "/home/${username}/.local/share/zsh/history";
                    share = true;
                    ignoreSpace = true;
                    ignoreAllDups = true;
                    saveNoDups = true;
                    expireDuplicatesFirst = true;
                };

                shellAliases = {
                    ls = "eza --color=always --icons=always --group-directories-first -a";
                    lsl = "eza --color=always --icons=always --group-directories-first -lAh --total-size";
                    nviz = "nvim $(fzf)";
                    nivm = "nvim";
                    cat = "bat --theme Nord -p -u -P";
                };

                initContent = ''
                    if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
                        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
                    fi

                    ZINIT_HOME="''${XDG_DATA_HOME:-''${HOME}/.local/share}/zinit/zinit.git"

                    # Install zinit if it's not already present
                    if [ ! -f "$ZINIT_HOME/zinit.zsh" ]; then
                        mkdir -p "$(dirname "$ZINIT_HOME")"
                        git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
                    fi

                    source "''${ZINIT_HOME}/zinit.zsh"

                    # Load everything as fast as possible
                    zinit ice depth=1
                    zinit light romkatv/powerlevel10k

                    zinit ice wait'0' lucid
                    zinit light zdharma-continuum/fast-syntax-highlighting
                    zinit light Aloxaf/fzf-tab

                    zinit cdreplay -q

                    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

                    bindkey -e
                    bindkey '^p' history-search-backward
                    bindkey '^n' history-search-forward
                    bindkey '^[w' kill-region
                    bindkey '^[[1;5D' backward-word
                    bindkey '^[[1;5C' forward-word

                    # Completion styling
                    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
                    zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
                    zstyle ':completion:*' menu no
                    zstyle ':fzf-tab:complete:*' show-hidden true

                    zstyle ':fzf-tab:complete:*' fzf-preview '
                        case "$realpath" in
                            *.pdf) pdftotext "$realpath" - | head -200 ;;
                            *.tar.gz|*.tgz|*.zst) tar -tzf "$realpath" ;;
                            *.zip) unzip -l "$realpath" ;;
                            *.md) glow -s dark "$realpath" ;;
                            *)
                                if [ -d "$realpath" ]; then
                                    eza --color=always --icons=always --group-directories-first -1 "$realpath"
                                else
                                    bat --theme="Nord" -p --color=always -- "$realpath"
                                fi
                            ;;
                        esac
                    '

                    eval "$(fzf --zsh)"
                    eval "$(zoxide init zsh)"
                '';

            };
        };
    };
}
