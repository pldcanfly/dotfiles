# zmodload zsh/zprof
# You may need to manually set your language environment
export LANG=en_US.UTF-8


## PLUGINS
# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zi light Aloxaf/fzf-tab
zi light zsh-users/zsh-syntax-highlighting

zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"

zinit light starship/starship

zi snippet OMZP::docker
zi snippet OMZP::npm
zi snippet OMZP::command-not-found

# Load zsh-completions async, and then run compinit async as well
zi for \
    atload"zicompinit; zicdreplay" \
    blockf \
    lucid \
    wait \
    zsh-users/zsh-completions

## PLUGINS END

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# aliases
alias vim="nvim"
alias ls='ls --color=auto'
alias ll="ls -la"
alias lg="lazygit"

# Shell integrations
eval "$(fzf --zsh)"

# Lazyloading nvm: https://github.com/lukechilds/zsh-nvm
export NVM_LAZY_LOAD=true
source "$XDG_CONFIG_HOME/zsh/nvm/zsh-nvm.plugin.zsh"

# Fix strange bug
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
bindkey "\e[3~" delete-char

# History
HISTSIZE=5000
HISTFILE=$XDG_CACHE_HOME/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# zstyle ':completion:*' menu no

# setp gopath
export PATH=/home/$USER/go/bin:$PATH

# opencode
export PATH=/home/$USER/.opencode/bin:$PATH
# zprof
