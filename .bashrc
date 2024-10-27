# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

export OSH="/home/fraccs/.oh-my-bash"
export UPDATE_OSH_DAYS=13 # Automatic update check

OSH_THEME="powerline"
OMB_CASE_SENSITIVE="true"
OMB_USE_SUDO=false
OMB_PROMPT_SHOW_PYTHON_VENV=true

completions=(
  git
  kubectl
  minikube
  pip
  pip3
  podman
  ssh
  tmux
)

aliases=(
  general
)

plugins=(
  ansible
  colored-man-pages
  git
  kubectl
  tmux-autoattach
)

source "$OSH"/oh-my-bash.sh

eval "$(zoxide init bash)"
