#!/bin/sh

# Creates root directories if they don't exist
mkdir -p "$HOME/.config" >/dev/null 2>&1

OS=`uname`

case $OS in
    "Darwin")
        SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
        ;;
    "Linux")
        SCRIPT_DIR=$(dirname "$(realpath "$0")")
        ;;
esac

# Get the directory of the script

# Remove existing files if they exist
rm -f "$HOME/.zshrc"
rm -f "$HOME/.bashrc"
rm -f "$HOME/.sh_common"
rm -f "$HOME/.config/starship.toml"

# Create symlinks for the dotfiles
if command -v zsh >/dev/null 2>&1; then
    # Create symlink only if zsh is installed
    ln -s "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
else
    # Create symlink for bash, otherwise
    ln -s "$SCRIPT_DIR/.bashrc" "$HOME/.bashrc"
fi
ln -s "$SCRIPT_DIR/.sh_common" "$HOME/.sh_common"

# Create a symlink for the starship configuration
ln -s "$SCRIPT_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

# Store this directory inside the rc file
echo "$SCRIPT_DIR" > $HOME/.dotshellrc

# install ux/uvx
curl -LsSf https://astral.sh/uv/install.sh | sh

# install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install starship
curl -sS https://starship.rs/install.sh | sh -s -- -y
