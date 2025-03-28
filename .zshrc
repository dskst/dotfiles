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
alias cat='bat'
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

eval "$(anyenv init -)"
# eval "$(goenv init -)"

## The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

## The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# functions
fssh() {
  grep -i '^host [^*]' ~/.ssh/config ~/.ssh/conf.d/hosts/* | cut -d ' ' -f 2 | fzf | xargs -o ssh
}

## ghq
function fzf-ghq() {
  local src=$(ghq list | fzf --prompt="ghqcd > " --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N fzf-ghq
bindkey '^G' fzf-ghq

## cdr
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':completion:*' recent-dirs-insert both
  zstyle ':chpwd:*' recent-dirs-default true
  zstyle ':chpwd:*' recent-dirs-max 1000
  zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

function fzf-cdr () {
    local selected_dir="$(cdr -l | sed 's/^[0-9]\+ \+//' | fzf --prompt="cdr > " --query "$LBUFFER" |awk '{print $2}')"
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
}
zle -N fzf-cdr
bindkey '^E' fzf-cdr

## surround
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround

# starship
eval "$(starship init zsh)"

# direnv
export EDITOR=vim
eval "$(direnv hook zsh)"
