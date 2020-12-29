# Prompt
PROMPT="[%n@%m %C]$ "

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
setopt hist_ignore_all_dups

# Color
export CLICOLOR=1
export LSCOLORS="GxFxCxDxBxegedabagaced"

# alias
alias ll='exa -la --git'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ghqcd='ghq get --look `ghq list |fzf`'
alias history='history 100| fzf'

# plugins
## zsh-syntax-highlighting
if [ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

## zsh-autosuggestions
if [ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

## zsh-ahistory-substring-search
if [ -f /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
  source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
fi

# path
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export LDFLAGS="-L/usr/local/opt/icu4c/lib"
export CPPFLAGS="-I/usr/local/opt/icu4c/include"
export PATH="/usr/local/opt/ncurses/bin:$PATH"
eval "$(anyenv init -)"
eval "$(goenv init -)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/lib/google-cloud-sdk/path.zsh.inc' ]; then source '/usr/local/lib/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/lib/google-cloud-sdk/completion.zsh.inc' ]; then source '/usr/local/lib/google-cloud-sdk/completion.zsh.inc'; fi

# functions
fssh() {
  grep -i '^host [^*]' ~/.ssh/config ~/.ssh/conf.d/hosts/* | cut -d ' ' -f 2 | fzf | xargs -o ssh
}
