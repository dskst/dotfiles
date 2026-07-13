# Suggest
autoload -Uz compinit
compinit
zstyle ':completion:*:default' menu select=1 # Cursor Selection

# Keybind
bindkey -v

# cd
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups

# Color
export CLICOLOR=1
export LSCOLORS="GxFxCxDxBxegedabagaced"

# alias
alias ll='eza -la --git'
alias ...='cd ../..'
alias ....='cd ../../..'

# plugins
export ZPLUG_HOME=/opt/homebrew/opt/zplug
#export ZPLUG_HOME=$(brew --prefix)/bin/zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
zplug "marzocchi/zsh-notify"

## Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load --verbose

## zsh-ahistory-substring-search
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

## fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey '^R' fzf-history-widget

# path
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export LDFLAGS="-L/usr/local/opt/icu4c/lib"
export CPPFLAGS="-I/usr/local/opt/icu4c/include"
export PATH="/usr/local/opt/ncurses/bin:$PATH"
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

eval "$(anyenv init -)"
# eval "$(goenv init -)"

## The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

## The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# functions
source "${${(%):-%N}:A:h}/.zsh/functions.zsh"

# widgets (ZLE)
source "${${(%):-%N}:A:h}/.zsh/widgets.zsh"

## surround
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround

# jdk
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Added by Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# starship
eval "$(starship init zsh)"

# direnv
export EDITOR=vim
eval "$(direnv hook zsh)"

