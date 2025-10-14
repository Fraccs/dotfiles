# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

alias cat="bat"
alias cd="z"
alias ls="eza"

export EDITOR="nvim"
# export OSH="$HOME/.oh-my-bash"
export PATH="$PATH:$HOME/.local/bin"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
# export UPDATE_OSH_DAYS=13 # Automatic update check

# OSH_THEME="powerline"
# OMB_CASE_SENSITIVE="true"
# OMB_USE_SUDO=false
# OMB_PROMPT_SHOW_PYTHON_VENV=true

# completions=(
#   git
#   kubectl
#   minikube
#   helm
#   pip
#   pip3
#   podman
#   ssh
#   tmux
# )
#
# aliases=(
#   general
# )
#
# plugins=(
#   ansible
#   colored-man-pages
#   git
#   kubectl
#   tmux-autoattach
# )

# source "$OSH"/oh-my-bash.sh
# source "/usr/share/nvm/init-nvm.sh"

eval "$(zoxide init bash)"
