#!/bin/bash

# Dotfiles sync script
# Copies config files from ~/.config to dot-configs repo

DOT_CONFIGS_DIR="$HOME/projects/dot-configs"

echo "Syncing dotfiles to $DOT_CONFIGS_DIR..."

# Sync nvim config
echo "Syncing nvim..."
rm -rf "$DOT_CONFIGS_DIR/nvim"
cp -r "$HOME/.config/nvim" "$DOT_CONFIGS_DIR/nvim"

# Sync kitty config
echo "Syncing kitty..."
rm -rf "$DOT_CONFIGS_DIR/kitty"
cp -r "$HOME/.config/kitty" "$DOT_CONFIGS_DIR/kitty"

# Sync VS Code settings (if exists)
if [ -d "$HOME/.config/Code/User" ]; then
    echo "Syncing VS Code..."
    mkdir -p "$DOT_CONFIGS_DIR/Code"
    cp "$HOME/.config/Code/User/settings.json" "$DOT_CONFIGS_DIR/Code/" 2>/dev/null
    cp "$HOME/.config/Code/User/keybindings.json" "$DOT_CONFIGS_DIR/Code/" 2>/dev/null
fi

# Sync powerline-shell config
if [ -f "$HOME/.config/powerline-shell/config.json" ]; then
    echo "Syncing powerline-shell..."
    mkdir -p "$DOT_CONFIGS_DIR/powerline-shell"
    cp "$HOME/.config/powerline-shell/config.json" "$DOT_CONFIGS_DIR/powerline-shell/"
fi

echo "Done!"
