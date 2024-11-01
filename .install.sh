#!/bin/bash

DOTFILES_REPO="https://github.com/fraccs/dotfiles.git"
DOTFILES_TMP_DIR="$HOME/dotfiles"

SEPARATOR="----------------------------------------"

echo $SEPARATOR

echo "Detected hostname: $HOSTNAME"
echo $SEPARATOR

if [[ "$HOSTNAME" == "laptop" || "$HOSTNAME" == "desktop" ]]; then
    echo "Continuing with the installation for $HOSTNAME..."
else
    read -p "Would you like to use the desktop or laptop configuration? (<desktop|laptop>): " config_choice

    while [[ "$config_choice" != "desktop" && "$config_choice" != "laptop" ]]; do
        echo "Invalid choice. Please enter 'desktop' or 'laptop'."
        read -p "Would you like to use the desktop or laptop configuration? (<desktop|laptop>): " config_choice
    done

    echo "You have chosen the $config_choice configuration."
fi

# TODO: replace *.<desktop|laptop>.* files with the correct ones (based on config_choice) and symlink properly

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
    echo "Cloning dotfiles repository..."
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

# source ~/.bashrc

echo "Setup completed!"
