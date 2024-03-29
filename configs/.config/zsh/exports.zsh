#!/bin/sh
# HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000
export EDITOR="nvim"
export TERMINAL="kitty"
export PATH="$HOME/.local/bin":$PATH
export PATH="$HOME/.docker/bin":$PATH
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/share/go/bin:$PATH
export PATH=$HOME/.fnm:$PATH
export PATH="$HOME/.local/share/neovim/bin":$PATH
export XDG_CURRENT_DESKTOP="Wayland"
#export PATH="$PATH:./node_modules/.bin"
eval "$(starship init zsh)"
# eval "`pip completion --zsh`"