#!/bin/bash

DOTFILES_REPO="https://github.com/fraccs/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

echo "Detected hostname: $HOSTNAME"

if [[ "$HOSTNAME" == "laptop" || "$HOSTNAME" == "desktop" ]]; then
    echo "Continuing with the installation for $HOSTNAME..."
else
    # read -p "The hostname is neither 'laptop' nor 'desktop'. Do you want the configuration for (d)esktop or (l)aptop? " choice
    # case "$choice" in
    #     [Dd]* )
    #         HOSTNAME="desktop"
    #         echo "Continuing with the installation for desktop..."
    #         ;;
    #     [Ll]* )
    #         HOSTNAME="laptop"
    #         echo "Continuing with the installation for laptop..."
    #         ;;
    #     * )
    #         echo "Invalid choice. Exiting."
    #         exit 1
    #         ;;
    # esac
fi

echo "Installing Oh My Bash..."

if [ -d "$HOME/.oh-my-bash" ]; then
    echo "Oh My Bash is already installed."
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
    echo "Oh My Bash installation completed."
fi

echo "Cloning dotfiles repository..."

if [ -d "$HOME/.git" ]; then
    echo "Dotfiles repository already exists."
else
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
    echo "Dotfiles repository cloned to $DOTFILES_DIR."

    mv "$DOTFILES_DIR/.git" "$HOME/"
    echo ".git directory moved to $HOME."

    rm -rf "$DOTFILES_DIR"
    echo "Original dotfiles directory removed."

    echo "Running 'git restore .' in the home directory..."
    cd "$HOME" || exit
    git restore .
    echo "'git restore .' completed."
fi

echo "Setup completed!"
