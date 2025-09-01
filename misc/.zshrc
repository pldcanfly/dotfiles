# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# aliases
alias vim="nvim"
alias ls='ls --color=auto'
alias ll="ls -la"
alias lg="lazygit"


# Lazyloading nvm: https://github.com/lukechilds/zsh-nvm
export NVM_LAZY_LOAD=true
source ~/.zsh-nvm/zsh-nvm.plugin.zsh

export PATH=$PATH:/home/$USER/.local/bin
eval "$(oh-my-posh init zsh --config ~/.config/omp.json)"

# Fix strange bug
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
bindkey "\e[3~" delete-char


# setp gopath
export PATH=/home/$USER/go/bin:$PATH

# opencode
export PATH=/home/$USER/.opencode/bin:$PATH
