#!/bin/bash

# Dotfiles sync script
# Copies config files from ~/.config to dot-configs repo

DOT_CONFIGS_DIR="$HOME/projects/dot-configs"

echo "Syncing dotfiles to $DOT_CONFIGS_DIR..."

# Sync nvim config
echo "Syncing nvim..."
rm -rf "$DOT_CONFIGS_DIR/nvim"
cp -r "$HOME/.config/nvim" "$DOT_CONFIGS_DIR/nvim"

echo "Done!"
