{ pkgs, username, config, lib, ... }:
let
    cfg = config.mySystem.applications.zsh;
in
{
    options.mySystem.applications.zsh = {
        enable = lib.mkEnableOption "Zsh module" // { default = true; };
        prompt = lib.mkOption {
            type = lib.types.enum [ "p10k" "starship" "none" ];
            default = "starship";
        };
    };

    config = lib.mkIf config.mySystem.applications.zsh.enable {
        environment.pathsToLink = [ "/share/zsh" ];
        users.users.${username}.shell = pkgs.zsh;
        programs.zsh = {
            enable = true;
            enableGlobalCompInit = false;
        };

        environment.systemPackages = with pkgs; [
            fzf
            eza
            glow
            poppler-utils
        ];

        programs.zoxide = {
            enable = true;
            enableZshIntegration = true;
            enableBashIntegration = true;
        };

        home-manager.users.${username} = {
            home.file.".local/share/zsh/p10k.zsh".source = ./.p10k.zsh;
            home.file.".config/starship.toml".source = ./starship.toml;
            programs = {
                fzf.enableZshIntegration = true;
                eza.enableZshIntegration = true;

                starship = lib.mkIf (cfg.prompt == "starship") {
                    enable = true;
                    enableBashIntegration = true;
                };
                
                zsh = {
                    enable = true;
                    history = {
                        size = 100000;
                        save = 100000;
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
                        nivm = "nvim";
                        run0 = "run0 --background=";
                        nv-run = "__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only GBM_BACKEND=nvidia-drm";
                    };

                    completionInit = "";

                    initContent = ''
                        ${lib.optionalString (cfg.prompt == "p10k") ''
                        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
                            source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
                        fi
                        ''}

                        ${lib.optionalString (cfg.prompt == "starship") ''
                        local starship_cache="$HOME/.local/share/starship-init.zsh"
                        if [ ! -f "$starship_cache" ]; then
                            starship init zsh > "$starship_cache"
                        fi
                        source "$starship_cache"
                        ''}

                        source ${pkgs.zinit}/share/zinit/zinit.zsh

                        ${lib.optionalString (cfg.prompt == "p10k") ''
                        zinit ice depth=1
                        zinit light romkatv/powerlevel10k
                        ''}

                        zinit ice wait'0' lucid
                        zinit light zdharma-continuum/fast-syntax-highlighting
                        zinit light Aloxaf/fzf-tab
                        zinit light zsh-users/zsh-autosuggestions
                        zinit light zsh-users/zsh-completions

                        autoload -U compinit
                        mkdir -p "$HOME/.local/share/zsh"
                        compinit -d "$HOME/.local/share/zsh/zcompdump-$ZSH_VERSION"
                        zinit cdreplay -q

                        ${lib.optionalString (cfg.prompt == "p10k") ''
                        if [ -f $HOME/.local/share/zsh/p10k.zsh ]; then
                            source $HOME/.local/share/zsh/p10k.zsh
                        fi
                        ''}

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
                            target="''${realpath:-$word}"
                            case "$target" in
                                *.service|*.socket|*.mount|*.automount|*.timer|*.path|*.target|*.swap|*.device|*.slice)
                                    SYSTEMD_COLORS=1 systemctl cat "$target" 2>/dev/null || cat "$target"
                                    ;;
                                *.pdf) pdftotext "$realpath" - | head -200 ;;
                                *.tar.gz|*.tgz) tar -tzf "$realpath" ;;
                                *.tar*) tar -tf "$realpath" ;;
                                *.zip) unzip -l "$realpath" ;;
                                *.md) glow -s dark "$realpath" ;;
                                *)
                                    if [ -d "$realpath" ]; then
                                        eza --color=always --icons=always --group-directories-first -1 "$realpath"
                                    else
                                        cat "$realpath"
                                    fi
                                ;;
                            esac
                        '

                        eval "$(${lib.getExe pkgs.fzf} --zsh)"
                        eval "$(${lib.getExe pkgs.zoxide} init zsh)"

                        ${lib.optionalString (cfg.prompt == "starship") ''
                        autoload -Uz add-zsh-hook
                        add-zsh-hook precmd transient-prompt-precmd

                        TRANSIENT_PROMPT="''${PROMPT// prompt / prompt --profile transient }"

                        function transient-prompt-precmd {
                            # Fix ctrl+c behavior
                            TRAPINT() { transient-prompt; return $(( 128 + $1 )) }
                            SAVED_PROMPT="$(eval "printf '%s' \"''${TRANSIENT_PROMPT}\"")"
                        }

                        autoload -Uz add-zle-hook-widget
                        add-zle-hook-widget zle-line-finish transient-prompt

                        function transient-prompt() {
                            PROMPT="$SAVED_PROMPT" zle .reset-prompt
                        }
                        ''}
                    '';
                };
            };
        };
    };
}
