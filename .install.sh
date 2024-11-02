#!/bin/bash

DOTFILES_REPO="https://github.com/fraccs/dotfiles.git"
DOTFILES_TMP_DIR="$HOME/dotfiles"

SEPARATOR="----------------------------------------"

REQUIRED_COMMANDS=(
    fd
    git
)

check_command() {
    command -v "$1" >/dev/null 2>&1
}

echo "Welcome to the 'fraccs/dotfiles' install script."
echo $SEPARATOR

echo "Detected hostname: $HOSTNAME"
echo $SEPARATOR

echo "Checking if required commands are installed..."

for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if check_command "$cmd"; then
        echo "$cmd is installed."
    else
        echo "$cmd is not installed."
        echo "Please install $cmd and then run this script again."
        exit 1
    fi
done

echo $SEPARATOR

if [[ "$HOSTNAME" == "laptop" || "$HOSTNAME" == "desktop" ]]; then
    echo "Continuing with the installation for $HOSTNAME."
else
    if [[ "$DOTFILES_TARGET" == "laptop" || "$DOTFILES_TARGET" == "desktop" ]]; then
        echo "The DOTFILES_TARGET environment variable is set to $DOTFILES_TARGET."
        echo "Continuing with the installation for $DOTFILES_TARGET."
    else
        echo "Please set the 'DOTFILES_TARGET' environment variable to either 'laptop' or 'desktop'."
        echo "Example: 'curl -sfL https://raw.githubusercontent.com/fraccs/dotfiles/refs/heads/main/.install.sh | DOTFILES_TARGET=laptop sh'."
        exit 1
    fi
fi

echo $SEPARATOR

if [ -d "$HOME/.oh-my-bash" ]; then
    echo "Oh My Bash is already installed."
    echo "Skipping Oh My Bash installation."
    echo $SEPARATOR
else
    echo "Installing Oh My Bash..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh) --unattended"
    echo "Oh My Bash installation completed."
    echo $SEPARATOR
fi

if [ -d "$HOME/.git" ]; then
    echo "Dotfiles repository already exists."
    echo "Skipping dotfiles repository clone."
    echo $SEPARATOR
else
    echo "Cloning 'fraccs/dotfiles'..."
    git clone "$DOTFILES_REPO" "$DOTFILES_TMP_DIR"
    echo "Dotfiles repository cloned to $DOTFILES_TMP_DIR."

    mv "$DOTFILES_TMP_DIR/.git" "$HOME/"
    echo ".git directory moved to $HOME."

    rm -rf "$DOTFILES_TMP_DIR"
    echo "Original dotfiles directory removed."

    cd "$HOME" || exit
    git restore .
    echo "git restore completed."
    echo $SEPARATOR
fi

if [[ "$HOSTNAME" == "desktop" || "$DOTFILES_TARGET" == "desktop" ]]; then
    symlink_targets=$(fd '^[^.]+\.desktop(\.[^.]+)?$')
    symlink_machine="desktop"
else
    symlink_targets=$(fd '^[^.]+\.laptop(\.[^.]+)?$')
    symlink_machine="laptop"
fi

readarray -t symlink_targets <<< "$symlink_targets"

for symlink_target in "${symlink_targets[@]}"; do
    symlink=$(echo "$symlink_target" | sed 's/\.'"$symlink_machine"'//')
    echo "Symlinking $symlink_target to $symlink."
    ln -s "$symlink_target" "$symlink"
done

echo $SEPARATOR

echo "Setup completed, please run 'source ~/.bashrc'."
