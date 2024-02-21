# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

HISTFILE=~/.zsh_history

# source
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"

plug "zsh-users/zsh-autosuggestions"
plug "esc/conda-zsh-completion"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "hlissner/zsh-autopair"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"
plug "zap-zsh/vim"
plug "zap-zsh/fzf"
plug "zap-zsh/exa"


# Load and initialise completion system
autoload -Uz compinit

eval "$(starship init zsh)"