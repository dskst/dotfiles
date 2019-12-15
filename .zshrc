# Prompt
PROMPT="[%n@%m %C]$ "

# Suggest
autoload -Uz compinit
compinit
zstyle ':completion:*:default' menu select=1 # Cursor Selection

# Keybind
bindkey -e

# cd
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

# History
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups

# Color
export CLICOLOR=1
export LSCOLORS="GxFxCxDxBxegedabagaced"

# alias
alias ll='ls -la'
#alias ls='ls --color=auto'
#alias ll='ls -la --color=auto'
#alias grep='grep --color=auto'

# plugins
## zsh-syntax-highlighting
if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

## zsh-autosuggestions
if [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# path
export PATH=$HOME/.nodebrew/current/bin:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/lib/google-cloud-sdk/path.zsh.inc' ]; then source '/usr/local/lib/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/lib/google-cloud-sdk/completion.zsh.inc' ]; then source '/usr/local/lib/google-cloud-sdk/completion.zsh.inc'; fi

# local settings
if [ -f ~/.zsh/local/local.zsh  ]; then
  source ~/.zsh/local/local.zsh
fi
