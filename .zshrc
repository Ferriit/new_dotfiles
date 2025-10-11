# ~/.zshrc

# Avoid running in non-interactive shells
[[ $- != *i* ]] && return

# --------------------------
# PATH setup
# --------------------------
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export PATH="$HOME/zig-linux-x86_64-0.14.0:$PATH"
export PATH="$HOME/terminal-doom/zig-out/bin:$PATH"
export PATH="$HOME/opt/cross/bin:$PATH"
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$PATH:/home/ferriit/.spicetify"

# Load Rust environment
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# --------------------------
# Zsh Setup
# --------------------------
autoload -Uz colors add-zsh-hook compinit
colors
compinit

# --------------------------
# Git branch parser
# --------------------------

parse_git_branch() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  [[ -n $branch ]] && echo " %F{5}[$branch]%f"  # Magenta for git
}

get_venv() {
  [[ -n "$VIRTUAL_ENV" ]] && echo " %F{13}($(basename $VIRTUAL_ENV))%f"  # Bright magenta for venv
}

set_prompt() {
  PS1="%F{5}%n%f@%F{13}%m %F{7}%1~%f$(parse_git_branch)$(get_venv) %F{5}➜ %f"
}

add-zsh-hook precmd set_prompt
# --------------------------
# Zsh Plugins
# --------------------------
# Autosuggestions
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting (must be last)
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Match syntax highlighting to Catppuccin Mocha (purple-focused)
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)

# Commands
ZSH_HIGHLIGHT_STYLES[command]='fg=5'               # valid commands → purple
ZSH_HIGHLIGHT_STYLES[precommand]='fg=5,bold'       # sudo, exec, etc → bold purple
ZSH_HIGHLIGHT_STYLES[unknown-command]='fg=1,bold'  # invalid commands → red (stands out)

# Arguments
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=5'   # purple
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=5'   # purple
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=13'     # cyan (for contrast)
ZSH_HIGHLIGHT_STYLES[assign]='fg=5'                   # var=value → purple

# Paths
ZSH_HIGHLIGHT_STYLES[path]='fg=6'                     # cyan for paths
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=6'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=5'                 # wildcards → purple

# Options and parameters
ZSH_HIGHLIGHT_STYLES[option]='fg=5'                   # command options (-a, --help) → purple
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=5'
ZSH_HIGHLIGHT_STYLES[default]='fg=7'                  # fallback → white/neutral

# Keywords / specials
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=5,bold'       # if, then, else, fi → bold purple
ZSH_HIGHLIGHT_STYLES[builtin]='fg=5'                  # cd, echo, etc → purple
ZSH_HIGHLIGHT_STYLES[function]='fg=5'                 # functions → purple
ZSH_HIGHLIGHT_STYLES[alias]='fg=5'                    # aliases → purple

# Strings
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=5'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=5'


# --------------------------
# Neofetch at shell start
# --------------------------
neofetch --ascii_distro arch

ferriit@Daniel-Artix ~ ➜ 
