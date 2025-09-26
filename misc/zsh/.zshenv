# XDG Base Directory Specification
# https://specifications.freedesktop.org/basedir-spec/latest/
XDG_DATA_HOME="$HOME/.local/share"
XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"

# redirect zsh
ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
. "$HOME/.cargo/env"
